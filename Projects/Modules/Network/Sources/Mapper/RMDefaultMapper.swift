import Foundation

struct RMDefaultMapper {
  static func map<T: Decodable>(type: T.Type, data: Data, response: HTTPURLResponse) throws -> T {
    if response.statusCode == 200 {
      do {
        let json = try JSONDecoder().decode(type, from: data)
        return json
      } catch {
        throw InvalidHTTPResponseError()
      }
    } else {
      throw InvalidHTTPResponseError()
    }
  }
}
