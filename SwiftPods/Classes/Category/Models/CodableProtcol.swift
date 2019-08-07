import UIKit
//https://www.jianshu.com/p/62162d01d1df?utm_campaign=hugo&utm_medium=reader_share&utm_content=note&utm_source=weixin-friends

struct Article1: Codable {
    var url: String
    var title: String
    var body: String
    var userId: String
}
func test1() {
    let dic1 = ["url":"http://baidu.com","title":"标题","body":"x文章内容","user_id":"9818"]
    let data1 = try? JSONSerialization.data(withJSONObject: dic1, options: [])
    let decoder1 = JSONDecoder()
    //设置解码器字段驼峰命名,即把json对象的user_id->userId
    decoder1.keyDecodingStrategy = .convertFromSnakeCase
    let model1 = try? decoder1.decode(Article1.self, from: data1!)
    print("\(model1!)")
}

/*
 修改转化字段，若字段不匹配则会闪退
 */
struct Article2: Codable {
    var url: String
    var title: String
    var body: String
    /*
     //可写在里面也可使用扩展
     enum CodingKeys: String, CodingKey {
     case url = "source_link"
     case title = "content_name"
     case body
     }*/
}
//使用扩展
extension Article2 {
    enum CodingKeys: String, CodingKey {
        case url = "source_link"
        case title = "content_name"
        case body
    }
}
func test2() {
    let dic2 = ["source_link":"http://baidu.com","content_name":"标题","body":"x文章内容"]
    let data2 = try? JSONSerialization.data(withJSONObject: dic2, options: [])
    let model2 = try? JSONDecoder().decode(Article2.self, from: data2!)
    print("\(model2!)")
}

//忽略键

struct NoteCollection: Codable {
    var name: String
    var notes: [String]
    var localDrafts = [String]()
}
//忽略localDrafts字段
extension NoteCollection {
    enum CodingKeys: CodingKey {
        case name
        case notes
    }
}

//创建匹配结构
let json = """
{
"currency": "PLN",
"rates": {
"USD": 3.76,
"EUR": 4.24,
"SEK": 0.41
}
}
"""
//我们希望将这些JSON响应转换为CurrencyConversion实例 - 每个实例包含一个ExchangeRate条目数组
struct Currency: Codable {
    var currency: String
}

struct CurrencyConversion: Decodable {
    
    var currency: Currency
    var exchangeRates: [ExchangeRate] {
        return rates.values
    }
    
    private var rates: ExchangeRate.List
}

struct ExchangeRate {
    let currency: Currency
    let rate: Double
}

private extension ExchangeRate {
    struct List: Decodable {
        let values: [ExchangeRate]
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let dictionary = try container.decode([String : Double].self)
            
            values = dictionary.map { (arg) -> ExchangeRate in
                
                let (key, value) = arg
                return ExchangeRate(currency: Currency(currency: key), rate: value)
            }
        }
    }
}

//类型转化
protocol StringRepresentable: CustomStringConvertible {
    init?(_ string: String)
}

extension Int: StringRepresentable {}

struct StringBacked<Value: StringRepresentable>: Codable {
    var value: Value
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        
        guard let value = Value(string) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: """
                Failed to convert an instance of \(Value.self) from "\(string)"
                """
            )
        }
        
        self.value = value
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value.description)
    }
}

//开始使用类型转化
struct Video: Codable {
    var title: String
    var description: String
    var url: URL
    var thumbnailImageURL: URL
    
    var numberOfLikes: Int {
        get { return likes.value }
        set { likes.value = newValue }
    }
    
    private var likes: StringBacked<Int>
}


