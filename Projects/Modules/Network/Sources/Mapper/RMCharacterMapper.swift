import Foundation
import CharacterInterface

struct RMCharacterMapper {
  static func map(data: Data, response: HTTPURLResponse) throws -> RMCharacterInfo {
    if response.statusCode == 200 {
      do {
        let json = try JSONDecoder().decode(RMCharacterInfo.self, from: data)
        return json
      } catch {
        throw InvalidHTTPResponseError()
      }
    } else {
      throw InvalidHTTPResponseError()
    }
  }
}
