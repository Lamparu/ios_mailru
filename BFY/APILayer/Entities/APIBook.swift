//
//  APIBook.swift
//  BFY
//
//  Created by Анастасия Московчук on 10.12.2021.
//

import Foundation

struct APIImageLinks: Codable {
    let smallThumbnail: String?
    let thumbnail: String?
}

struct APIPanelizationSummary: Codable {
    let containsEpubBubbles: String
    let containsImageBubbles: String
}

struct APIReadingModes: Codable {
    let text: Bool
    let image: Bool
}

struct APIIndustryIdentifiers: Codable {
    let type: String
    let identifier: String
}

struct APIVolumeInfo: Codable {
    let title: String
//    let subtitle: String?
    let authors: [String]?
//    let publishedDate: String
//    let industryIdentifiers: [APIIndustryIdentifiers]
//    let readingModes: APIReadingModes
//    let pageCount: Int
//    let printType: String
//    let maturityRating: String
//    let allowAnonLogging: Bool
//    let contentVersion: String
//    let panelizationSummary: APIPanelizationSummary
//    let language: String
//    let previewLink: String
//    let infoLink: String
//    let canonicalVolumeLink: String
    let imageLinks: APIImageLinks?
}

struct APISaleInfo: Codable {
    let country: String
    let saleability: String
    let isEbook: Bool
}

struct APIEpub: Codable {
    let isAvailable: Bool
}

struct APIPdf: Codable {
    let isAvailable: Bool
}

struct APIAccessInfo: Codable {
    let country: String
    let viewability: String
    let embeddable: Bool
    let publicDomain: Bool
    let textToSpeechPermission: String
    let epub: APIEpub
    let pdf: APIPdf
    let webReaderLink: String
    let accessViewStatus: String
    let quoteSharingAllowed: Bool
}

struct BooksBody: Codable {
//    let kind: String
    let id: String
//    let etag: String
//    let selfLink: String
//    let selfLink: URL
    let volumeInfo: APIVolumeInfo
//    let saleInfo: APISaleInfo
//    let accessInfo: APIAccessInfo
}

struct APIBook: Decodable  {
    let kind: String
    let totalItems: Int
    let items: [BooksBody]
}

//struct Book: Decodable {
//    let kind: String
//    let totalItems: Int
//    let items: [APIBook]
//}
//
//struct APIBook: Decodable {
//    let kind, id, etag, selfLink: String
//    let volumeInfo: VolumeInfo
//    let saleInfo: SaleInfo
//    let accessInfo: AccessInfo
//}
//
//struct AccessInfo: Decodable {
//    let country, viewability: String
//    let embeddable, publicDomain: Bool
//    let textToSpeechPermission: String
//    let epub, pdf: Epub
//    let webReaderLink, accessViewStatus: String
//    let quoteSharingAllowed: Bool
//}
//
//struct Epub: Decodable {
//    let isAvailable: Bool
//}
//
//struct SaleInfo: Decodable {
//    let country, saleability: String
//    let isEbook: Bool
//}
//
//struct VolumeInfo: Decodable {
//    let title: String
//    let authors: [String]
//    let publisher, publishedDate, description: String
//    let industryIdentifiers: [IndustryIdentifier]
//    let readingModes: ReadingModes
//    let pageCount, printedPageCount: Int
//    let dimensions: Dimensions
//    let printType: String
//    let categories: [String]
//    let averageRating: Double
//    let ratingsCount: Int
//    let maturityRating: String
//    let allowAnonLogging: Bool
//    let contentVersion: String
//    let panelizationSummary: PanelizationSummary
//    let imageLinks: ImageLinks
//    let language, previewLink, infoLink, canonicalVolumeLink: String
//}
//
//struct Dimensions: Decodable {
//    let height, width, thickness: String
//}
//
//struct ImageLinks: Decodable {
//    let smallThumbnail, thumbnail: String
//}
//
//struct IndustryIdentifier: Decodable {
//    let type, identifier: String
//}
//
//struct PanelizationSummary: Decodable {
//    let containsEpubBubbles, containsImageBubbles: Bool
//}
//
//struct ReadingModes: Decodable {
//    let text, image: Bool
//}

//_______________________
//struct APIImageLinks: Decodable {
//    let smallThumbnail: String
//    let thumbnail: String
//}
//
//struct APIVolumeInfo: Decodable {
//    let title: String
//    let authors: [String]
//    let imageLinks: APIImageLinks
//}
//
//struct BooksBody: Decodable {
//    let id: String
//    let volumeInfo: APIVolumeInfo
//}
//
//struct APIBook: Decodable  {
//    let items: [BooksBody]
//}

//_____________________
//struct APIImageLinks: Decodable {
//    let smallThumbnail: String
//    let thumbnail: String
//}
//
//struct APIPanelizationSummary: Decodable {
//    let containsEpubBubbles: String
//    let containsImageBubbles: String
//}
//
//struct APIReadingModes: Decodable {
//    let text: Bool
//    let image: Bool
//}
//
//struct APIIndustryIdentifiers: Decodable {
//    let type: String
//    let identifier: String
//}
//
//struct APIVolumeInfo: Decodable {
//    let title: String
//    let subtitle: String?
//    let authors: [String]
//    let publishedDate: String
//    let industryIdentifiers: [APIIndustryIdentifiers]
//    let readingModes: APIReadingModes
//    let pageCount: Int
//    let printType: String
//    let maturityRating: String
//    let allowAnonLogging: Bool
//    let contentVersion: String
//    let panelizationSummary: APIPanelizationSummary
//    let language: String
//    let previewLink: String
//    let infoLink: String
//    let canonicalVolumeLink: String
////    let imageLinks: APIImageLinks
//}
//
//struct APISaleInfo: Decodable {
//    let country: String
//    let saleability: String
//    let isEbook: Bool
//}
//
//struct APIEpub: Decodable {
//    let isAvailable: Bool
//}
//
//struct APIPdf: Decodable {
//    let isAvailable: Bool
//}
//
//struct APIAccessInfo: Decodable {
//    let country: String
//    let viewability: String
//    let embeddable: Bool
//    let publicDomain: Bool
//    let textToSpeechPermission: String
//    let epub: APIEpub
//    let pdf: APIPdf
//    let webReaderLink: String
//    let accessViewStatus: String
//    let quoteSharingAllowed: Bool
//}
//
//struct BooksBody: Decodable {
//    let kind: String
//    let id: String
//    let etag: String
//    let selfLink: String
//    let volumeInfo: APIVolumeInfo
//    let saleInfo: APISaleInfo
//    let accessInfo: APIAccessInfo
//}
//
//struct APIBook: Decodable  {
//    let kind: String
//    let totalItems: Int
//    let items: [BooksBody]
//}


/*
 {
   "kind": "books#volumes", +
   "totalItems": 1481, +
   "items": [ +
     {
       "kind": "books#volume", +
       "id": "PEpbAQAACAAJ", +
       "etag": "9Wdn9wKwXvs", +
       "selfLink": + "https://www.googleapis.com/books/v1/volumes/PEpbAQAACAAJ",
       "volumeInfo": {
         "title": "Капитанская дочка", +
         "subtitle": "Повести", +
         "authors": [ +
           "Александр Сергеевич Пушкин"
         ],
         "publishedDate": "2014",
         "industryIdentifiers": [
           {
             "type": "ISBN_10",
             "identifier": "538904732X"
           },
           {
             "type": "ISBN_13",
             "identifier": "9785389047327"
           }
         ],
         "readingModes": {
           "text": false,
           "image": false
         },
         "pageCount": 475,
         "printType": "BOOK",
         "maturityRating": "NOT_MATURE",
         "allowAnonLogging": false,
         "contentVersion": "preview-1.0.0",
         "panelizationSummary": {
           "containsEpubBubbles": false,
           "containsImageBubbles": false
         },
         "language": "ru",
         "previewLink": "http://books.google.ru/books?id=PEpbAQAACAAJ&dq=%D0%9A%D0%B0%D0%BF%D0%B8%D1%82%D0%B0%D0%BD%D1%81%D0%BA%D0%B0%D1%8F+%D0%B4%D0%BE%D1%87%D0%BA%D0%B0&hl=&cd=1&source=gbs_api",
         "infoLink": "http://books.google.ru/books?id=PEpbAQAACAAJ&dq=%D0%9A%D0%B0%D0%BF%D0%B8%D1%82%D0%B0%D0%BD%D1%81%D0%BA%D0%B0%D1%8F+%D0%B4%D0%BE%D1%87%D0%BA%D0%B0&hl=&source=gbs_api",
         "canonicalVolumeLink": "https://books.google.com/books/about/%D0%9A%D0%B0%D0%BF%D0%B8%D1%82%D0%B0%D0%BD%D1%81%D0%BA%D0%B0%D1%8F_%D0%B4%D0%BE%D1%87%D0%BA%D0%B0.html?hl=&id=PEpbAQAACAAJ"
       },
       "saleInfo": {
         "country": "RU",
         "saleability": "NOT_FOR_SALE",
         "isEbook": false
       },
       "accessInfo": {
         "country": "RU",
         "viewability": "NO_PAGES",
         "embeddable": false,
         "publicDomain": false,
         "textToSpeechPermission": "ALLOWED",
         "epub": {
           "isAvailable": false
         },
         "pdf": {
           "isAvailable": false
         },
         "webReaderLink": "http://play.google.com/books/reader?id=PEpbAQAACAAJ&hl=&printsec=frontcover&source=gbs_api",
         "accessViewStatus": "NONE",
         "quoteSharingAllowed": false
       }
     },
 
 */
