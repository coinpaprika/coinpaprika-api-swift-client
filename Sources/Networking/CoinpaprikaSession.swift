//
//  CoinpaprikaSession.swift
//  Coinpaprika
//

import Foundation

/// `NetworkSession` implementation backed by `URLSession` with redirect handling
/// tuned for the CoinPaprika API.
///
/// Two redirect quirks that this session works around:
///
/// 1. The `/contracts/{platform}/{address}` and `/contracts/.../historical`
///    endpoints respond with a `301` whose `Location` uses the `http://` scheme
///    even when the original request was `https://`. On Apple platforms ATS
///    typically upgrades the redirect target back to `https://` before the
///    delegate fires, but the session also performs the upgrade explicitly as
///    defense-in-depth for environments where ATS is disabled.
///
/// 2. CFNetwork strips the `Authorization` header on cross-redirect (and
///    substitutes a default `Accept`) as part of its sensitive-header policy.
///    For redirects to a `coinpaprika.com` host this session re-attaches the
///    original request's `Authorization`, `Accept`, and `User-Agent` headers
///    so the redirected call still authenticates against api-pro.
///
/// Used by default in `Request.perform(...)`. To opt out and use a vanilla
/// `URLSession`, pass it explicitly:
///
///     myRequest.perform(session: URLSession.shared) { ... }
public final class CoinpaprikaSession: NetworkSession {

    /// Shared instance used as the default `NetworkSession` by `Request.perform(...)`.
    public static let shared = CoinpaprikaSession()

    private let session: URLSession

    /// Creates a new session. In most cases use `CoinpaprikaSession.shared` instead.
    /// - Parameter configuration: URLSession configuration; defaults to `.default`.
    public init(configuration: URLSessionConfiguration = .default) {
        let delegate = RedirectRewriter()
        self.session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
    }

    public func loadData(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = session.dataTask(with: request) { data, response, error in
            completionHandler(data, response, error)
        }
        task.resume()
    }
}

/// `URLSessionTaskDelegate` that handles the two CoinPaprika-specific redirect
/// quirks: scheme upgrade for `http://*.coinpaprika.com` targets, and
/// re-attaching `Authorization`/`Accept`/`User-Agent` headers that CFNetwork
/// strips on cross-redirect. Internal — used only by `CoinpaprikaSession`.
final class RedirectRewriter: NSObject, URLSessionTaskDelegate {

    /// Headers CFNetwork strips on redirect that the SDK needs preserved when
    /// the redirect target is still a coinpaprika host.
    static let preservedHeaders = ["Authorization", "Accept", "User-Agent"]

    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    willPerformHTTPRedirection response: HTTPURLResponse,
                    newRequest: URLRequest,
                    completionHandler: @escaping (URLRequest?) -> Void) {
        completionHandler(rewrite(newRequest, originalRequest: task.originalRequest))
    }

    /// Returns a request with:
    ///
    /// - URL scheme upgraded to `https` if the host is a `coinpaprika.com`
    ///   subdomain and the scheme was `http`. Apple platforms with ATS already
    ///   do this; the explicit upgrade covers ATS-disabled environments.
    /// - `Authorization`, `Accept`, and `User-Agent` re-attached from
    ///   `originalRequest` when the redirect target is a coinpaprika host and
    ///   those headers were stripped by CFNetwork's sensitive-header policy.
    ///
    /// Non-coinpaprika hosts pass through unchanged.
    func rewrite(_ request: URLRequest, originalRequest: URLRequest? = nil) -> URLRequest {
        var rewritten = request

        if let url = rewritten.url,
           url.scheme?.lowercased() == "http",
           isCoinpaprikaHost(url),
           var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            components.scheme = "https"
            if let httpsUrl = components.url {
                rewritten.url = httpsUrl
            }
        }

        if isCoinpaprikaHost(rewritten.url), let original = originalRequest {
            for header in RedirectRewriter.preservedHeaders {
                if rewritten.value(forHTTPHeaderField: header) == nil,
                   let value = original.value(forHTTPHeaderField: header) {
                    rewritten.setValue(value, forHTTPHeaderField: header)
                }
            }
        }

        return rewritten
    }

    private func isCoinpaprikaHost(_ url: URL?) -> Bool {
        guard let host = url?.host?.lowercased() else { return false }
        return host == "coinpaprika.com" || host.hasSuffix(".coinpaprika.com")
    }
}
