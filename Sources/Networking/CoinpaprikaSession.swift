//
//  CoinpaprikaSession.swift
//  Coinpaprika
//

import Foundation

/// `NetworkSession` implementation backed by `URLSession` with redirect handling
/// tuned for the CoinPaprika API.
///
/// Some CoinPaprika endpoints (notably `/contracts/{platform}/{address}` and its
/// `/historical` variant) respond with a `301` whose `Location` uses the `http://`
/// scheme even when the original request was `https://`. On `api-pro.coinpaprika.com`
/// the `http` host returns no body, so a default `URLSession` that blindly follows
/// the redirect ends up empty-handed.
///
/// `CoinpaprikaSession` rewrites the redirect target back to `https://` for any
/// `coinpaprika.com` host before letting URLSession follow it. Behaviour for
/// non-CoinPaprika hosts is unchanged (the redirect is followed as-is).
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

/// `URLSessionTaskDelegate` that rewrites `http://*.coinpaprika.com` redirect
/// targets to `https://`. Internal — used only by `CoinpaprikaSession`.
final class RedirectRewriter: NSObject, URLSessionTaskDelegate {

    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    willPerformHTTPRedirection response: HTTPURLResponse,
                    newRequest: URLRequest,
                    completionHandler: @escaping (URLRequest?) -> Void) {
        completionHandler(rewrite(newRequest))
    }

    /// Returns a request with the URL scheme upgraded to `https` if the original
    /// scheme was `http` and the host is a `coinpaprika.com` subdomain. Otherwise
    /// returns the request unchanged.
    func rewrite(_ request: URLRequest) -> URLRequest {
        guard
            let url = request.url,
            url.scheme?.lowercased() == "http",
            let host = url.host?.lowercased(),
            host == "coinpaprika.com" || host.hasSuffix(".coinpaprika.com"),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        else {
            return request
        }

        components.scheme = "https"

        guard let rewritten = components.url else {
            return request
        }

        var copy = request
        copy.url = rewritten
        return copy
    }
}
