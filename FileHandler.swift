//
//  FileHandler.swift
//  FLAGMAPPER
//
//  Created by Kiran McCulloch on 2023-02-01.
//

import Foundation

//func loadFMFlagFromString(FMFlagString: String) -> FMFlag{
//    
//}
//
//func loadFMLocationFromString(FMLocationString: String) -> FMLocation{
//    
//}

func writeLine(file: String, text: String){
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = dir.appendingPathComponent(file)
        //writing
        do {
            try text.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {/* error handling here */}
    }
}

func readLine(file: String, text: String) -> String{
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = dir.appendingPathComponent(file)
        //reading
        do {
            let text2 = try String(contentsOf: fileURL, encoding: .utf8)
            return text2;
        }
        catch {/* error handling here */}
    }
    return "null"
}



