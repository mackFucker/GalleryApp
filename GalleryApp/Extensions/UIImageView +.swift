//
//  UIImageView +.swift
//  GalleryApp
//
//  Created by Дэвид Кихтенко on 16.02.2024.
//

import UIKit

extension UIImageView {

    func setImage(url: String) {
        Task {
            do {
                let image = try await loadImage(for: URL(string: url)!)
                self.image = image
            } catch {
                print(error.localizedDescription)
                self.image = nil
            }
        }
    }
    
    private func loadImage(for url: URL) async throws -> UIImage {
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let response = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }

        return image
    }
}
