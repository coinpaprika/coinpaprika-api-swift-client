//
//  KeyInfo.swift
//  Coinpaprika
//

import Foundation
#if canImport(CoinpaprikaNetworking)
import CoinpaprikaNetworking
#endif

/// API key information returned by `/key/info` (paid plans).
public struct KeyInfo: Equatable, CodableModel {

    /// Name of the API plan, eg. `pro`, `business`, `enterprise`.
    public let plan: String?

    /// Date the plan started, RFC3999 (ISO-8601) format.
    public let planStartedAt: String?

    /// Plan status: `active`, `past_due`, or `inactive`.
    public let planStatus: String?

    /// API customer portal URL.
    public let portalUrl: String?

    /// Monthly usage information.
    public let usage: Usage?

    public struct Usage: Equatable, CodableModel {

        /// `limited plan` if requests are capped on the current plan, `unlimited plan` otherwise.
        public let message: String?

        /// Current calendar-month usage stats.
        public let currentMonth: Period?

        public struct Period: Equatable, CodableModel {

            /// Requests made in the current month. `-1` for unlimited plans.
            public let requestsMade: Int?

            /// Requests left in the current month. `-1` for unlimited plans.
            public let requestsLeft: Int?

            enum CodingKeys: String, CodingKey {
                case requestsMade = "requests_made"
                case requestsLeft = "requests_left"
            }
        }

        enum CodingKeys: String, CodingKey {
            case message
            case currentMonth = "current_month"
        }
    }

    enum CodingKeys: String, CodingKey {
        case plan
        case planStartedAt = "plan_started_at"
        case planStatus = "plan_status"
        case portalUrl = "portal_url"
        case usage
    }
}
