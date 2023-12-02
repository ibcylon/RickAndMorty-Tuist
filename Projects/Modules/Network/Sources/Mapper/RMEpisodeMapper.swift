import Foundation
import EpisodeInterface

struct RMEpisodeMapper {
  static func map(data: Data, response: HTTPURLResponse) throws -> RMEpisodeInfo {
    if response.statusCode == 200 {
      do {
        let json = try JSONDecoder().decode(RMEpisodeInfo.self, from: data)
        return json
      } catch {
        throw InvalidHTTPResponseError()
      }
    } else {
      throw InvalidHTTPResponseError()
    }
  }
}
