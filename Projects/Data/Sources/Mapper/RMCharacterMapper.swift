
import Foundation
import Networks
import CharacterInterface

struct RMCharacterMapper {
  static func map(data: Data, response: HTTPURLResponse) throws -> RMCharacterDTO {
    if response.statusCode == 200 {
      do {
        let json = try JSONDecoder().decode(RMCharacterDTO.self, from: data)
        return json
      } catch {
        throw RemoteError.decode
      }
    } else {
      throw InvalidHTTPResponseError()
    }
  }
}
