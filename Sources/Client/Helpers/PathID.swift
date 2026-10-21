//
//  PathID.swift
//  Coinpaprika
//

import Foundation

/// Encodes a caller-supplied id (a coin id, platform id, contract address,
/// exchange id, tag id or person id) so it can never widen the request
/// beyond the single path segment the calling endpoint method intends.
///
/// `URL.appendingPathComponent`, used to build every request's URL, already
/// percent-encodes "?", "#", "%" and "\" found anywhere in the component
/// string, so those cannot inject a query string or a fragment. It does not
/// escape "/", because "/" is a legitimate path separator in a component
/// string that may itself be multiple segments, and it does not escape "."
/// or "..", because those are valid, unreserved path characters under RFC
/// 3986. That leaves two gaps this function closes:
///
/// - A literal "/" in the id would add an extra path segment (for example
///   id "a/b" turning "coins/a/b" into two segments instead of one).
/// - An id that is exactly "." or ".." would make the templated path
///   contain a real dot-segment (for example "coins/.." or
///   "coins/../key/info"), which URL normalization can resolve out of the
///   intended endpoint entirely.
///
/// Escaping "/" and special-casing a whole "." or ".." id removes the
/// dependency on how any downstream URL parser treats those characters,
/// instead of relying on it.
func encodedPathID(_ id: String) -> String {
    if id == "." {
        return "%2E"
    }
    if id == ".." {
        return "%2E%2E"
    }

    return id.replacingOccurrences(of: "/", with: "%2F")
}
