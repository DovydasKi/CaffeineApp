//
//  DetailedCoffeeViewModel.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-25.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class DetailedCoffeeViewModel {
    public func setPriceForSelectedCoffee(imageView: UIImageView, cupSizesArray: inout [UIImageView], cupSizesDict: inout [UIImageView:Bool], imageName: String, priceTagLabel: inout UILabel) {
    
        guard let selectedImage = cupSizesDict.first(where: { $0.value == true })?.key else {return}
        guard let indexOfSelectedImage = cupSizesArray.firstIndex(of: selectedImage) else {return}
        guard let indexOfPressedImage = cupSizesArray.firstIndex(of: imageView) else {return}
                
        if cupSizesDict[imageView] == true { return }
        
        for key in cupSizesDict.keys { cupSizesDict[key] = false }

        cupSizesDict[imageView] = true
        
        self.setInactive(index: indexOfSelectedImage, cupSizesArray: &cupSizesArray)
        self.setActive(index: indexOfPressedImage, cupSizesArray: &cupSizesArray)
        priceTagLabel.text = self.setPrice(imageName: imageName, indexOfImage: indexOfPressedImage, priceTagLabel: priceTagLabel)
    }
    
    private func setActive(index: Int, cupSizesArray: inout [UIImageView]) {
        switch index {
            case 0:
                cupSizesArray[0].image = #imageLiteral(resourceName: "sCupFilled")
            case 1:
                cupSizesArray[1].image = #imageLiteral(resourceName: "mCupFilled")
            case 2:
                cupSizesArray[2].image = #imageLiteral(resourceName: "lCupFilled")
            default:
                return
        }
    }
    
    private func setInactive(index: Int, cupSizesArray: inout [UIImageView]) {
        switch index {
            case 0:
                cupSizesArray[0].image = #imageLiteral(resourceName: "sCupOutline")
            case 1:
                cupSizesArray[1].image = #imageLiteral(resourceName: "mCupOutline")
            case 2:
                cupSizesArray[2].image = #imageLiteral(resourceName: "lCupOutline")
            default:
                return
        }
    }
    
    public func setPrice(imageName: String, indexOfImage: Int, priceTagLabel: UILabel) -> String {

        switch imageName {
        case "Cappuccino":
            return convertDoubleToString(number: adjustPriceAcordingToCupSize(indexOfImage: indexOfImage, basePrice: 2.4, isDefault: false)) + "€"
        case "Latte":
            return convertDoubleToString(number: adjustPriceAcordingToCupSize(indexOfImage: indexOfImage, basePrice: 2.5, isDefault: false)) + "€"
        case "Black Coffee":
            return convertDoubleToString(number: adjustPriceAcordingToCupSize(indexOfImage: indexOfImage, basePrice: 1.9, isDefault: false)) + "€"
        case "White Coffee":
            return convertDoubleToString(number: adjustPriceAcordingToCupSize(indexOfImage: indexOfImage, basePrice: 1.9, isDefault: false)) + "€"
        case "Mocha":
            return convertDoubleToString(number: adjustPriceAcordingToCupSize(indexOfImage: indexOfImage, basePrice: 2.6, isDefault: false)) + "€"
        case "Flat White":
            return convertDoubleToString(number: adjustPriceAcordingToCupSize(indexOfImage: indexOfImage, basePrice: 2.3, isDefault: false)) + "€"
        default:
            break
        }
        return ""
    }
    
    private func adjustPriceAcordingToCupSize(indexOfImage: Int?, basePrice: Double, isDefault: Bool) -> Double{
        var price = basePrice
        guard let index = indexOfImage else { return basePrice }
        if (isDefault) {
            return price
        }
        else {
            switch index {
                case 0:
                    price -= 0.3
                case 1:
                    break
                case 2:
                    price += 0.4
                default:
                    return price
            }
        }
        return price
    }
    
    public func setDefaultPrice(imageName: String, priceTagLabel: UILabel) -> String{
        switch imageName {
        case "Cappuccino":
            return convertDoubleToString(number: adjustPriceAcordingToCupSize(indexOfImage: nil, basePrice: 2.4, isDefault: true)) + "€"
        case "Latte":
            return convertDoubleToString(number: adjustPriceAcordingToCupSize(indexOfImage: nil, basePrice: 2.5, isDefault: true)) + "€"
        case "Black Coffee":
            return convertDoubleToString(number: adjustPriceAcordingToCupSize(indexOfImage: nil,  basePrice: 1.9, isDefault: true)) + "€"
        case "White Coffee":
            return convertDoubleToString(number: adjustPriceAcordingToCupSize(indexOfImage: nil,  basePrice: 1.9, isDefault: true)) + "€"
        case "Mocha":
            return convertDoubleToString(number: adjustPriceAcordingToCupSize(indexOfImage: nil,  basePrice: 2.6, isDefault: true)) + "€"
        case "Flat White":
            return convertDoubleToString(number: adjustPriceAcordingToCupSize(indexOfImage: nil,  basePrice: 2.3, isDefault: true)) + "€"
        default:
            break
        }
        return ""
    }
    
    private func convertStringToDouble(string: String) -> Double {
        return  NSString(format: "%.1", string).doubleValue
    }
    
    private func convertDoubleToString(number: Double) -> String {
        return String(format: "%.1f", number)
    }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}

