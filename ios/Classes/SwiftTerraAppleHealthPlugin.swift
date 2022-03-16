import Flutter
import UIKit
import TerraSwift

public class SwiftTerraAppleHealthPlugin: NSObject, FlutterPlugin {

  var terraClient: TerraSwift.Terra?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "terra_apple_health", binaryMessenger: registrar.messenger())
    let instance = SwiftTerraAppleHealthPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
      if call.method == "auth" {
          if let args = call.arguments as? Dictionary<String, Any>, let apiKey = args["apiKey"] as? String,
             let devId = args["devId"] as? String {
              let referenceId: String? = args["referenceId"] as? String
              auth(devID: devId, apiKey: apiKey, referenceID: referenceId, result: result)
          } else {
              result(["success": false, "method": "AUTH", "message" : "Invalid Call Arguments"])
          }
      } else if call.method == "initTerra" {
          if let args = call.arguments as? Dictionary<String, Any>, let apiKey = args["apiKey"] as? String,
             let devId = args["devId"] as? String, let autoFetch = args["autoFetch"] as? Bool {
              do{
                   terraClient = try TerraSwift.Terra(dev_id: devId, xAPIKey: apiKey, auto: autoFetch){(success: Bool) in
                       result(["success": success, "method": "initTerra" ])}
                 } catch {
                     result(["success": false, "method": "initTerra", "message": "Init failed, further debug messages avaialble in Xcode" ])
                 }
          }
      } else if call.method == "deauth"  {
          terraClient = nil
      } else if call.method == "getDaily" {
          getDaily(arguments: call.arguments, result: result)
      } else if call.method == "getSleep" {
          getSleep(arguments: call.arguments, result: result)
      } else if call.method == "getBody" {
          getBody(arguments: call.arguments, result: result)
      } else if call.method == "getActivity" {
          getActivity(arguments: call.arguments, result: result)
      } else if call.method == "getAthlete" {
          getAthlete()
      } 
      
  }
    
  // Terra Helper Methods
    func auth(devID: String, apiKey: String, referenceID: String?, result: @escaping FlutterResult){
        guard let terraAuthResponse = TerraSwift.connectTerra(dev_id: devID, xAPIKey: apiKey, referenceId: referenceID) else {
            result(["success": false, "method": "AUTH", "message" : "Auth failed, further debug messages avaialble in Xcode"])
              return
            }
        print(terraAuthResponse)
        // The User ID is to be saved by the client
        result(["success": true, "method": "AUTH", "status" : terraAuthResponse.status, "terra_id": terraAuthResponse.user_id ?? "N/A"])
        
    }
    
     // data functions
    
     func getBody(arguments: Any?, result: @escaping FlutterResult){
         
      if let args = arguments as? Dictionary<String, Any>, let startDate = args["startDate"] as? String, let endDate = args["endDate"] as? String {
             let parsedStartDate = parseIso8601Date(dateString: startDate)
             let parsedEndDate  = parseIso8601Date(dateString: endDate)
             if (parsedStartDate == nil || parsedEndDate == nil){
                 result(["success": false, "method": "getBody", "message" : "Invalid Call Arguments"])
             } else {
                 terraClient?.getBody(startDate: parsedStartDate!, endDate: parsedEndDate!)
             }
       } else {
             result(["success": false, "method": "getBody", "message" : "Invalid Call Arguments"])
       }
       
     }
    
     func getDaily(arguments: Any?, result: @escaping FlutterResult){
         if let args = arguments as? Dictionary<String, Any>, let startDate = args["startDate"] as? String, let endDate = args["endDate"] as? String {
                let parsedStartDate = parseIso8601Date(dateString: startDate)
                let parsedEndDate  = parseIso8601Date(dateString: endDate)
                if (parsedStartDate == nil || parsedEndDate == nil){
                    result(["success": false, "method": "getDaily", "message" : "Invalid Call Arguments"])
                } else {
                    terraClient?.getDaily(startDate: parsedStartDate!, endDate: parsedEndDate!)
                }
          } else {
                result(["success": false, "method": "getDaily", "message" : "Invalid Call Arguments"])
          }
     }
     func getSleep(arguments: Any?, result: @escaping FlutterResult){
         if let args = arguments as? Dictionary<String, Any>, let startDate = args["startDate"] as? String, let endDate = args["endDate"] as? String {
                let parsedStartDate = parseIso8601Date(dateString: startDate)
                let parsedEndDate  = parseIso8601Date(dateString: endDate)
                if (parsedStartDate == nil || parsedEndDate == nil){
                    result(["success": false, "method": "getSleep", "message" : "Invalid Call Arguments"])
                } else {
                    terraClient?.getSleep(startDate: parsedStartDate!, endDate: parsedEndDate!)
                }
          } else {
                result(["success": false, "method": "getSleep", "message" : "Invalid Call Arguments"])
          }
     }
    
     func getActivity(arguments: Any?, result: @escaping FlutterResult){
         if let args = arguments as? Dictionary<String, Any>, let startDate = args["startDate"] as? String, let endDate = args["endDate"] as? String {
                let parsedStartDate = parseIso8601Date(dateString: startDate)
                let parsedEndDate  = parseIso8601Date(dateString: endDate)
                if (parsedStartDate == nil || parsedEndDate == nil){
                    result(["success": false, "method": "getActivity", "message" : "Invalid Call Arguments"])
                } else {
                    terraClient?.getWorkout(startDate: parsedStartDate!, endDate: parsedEndDate!)
                }
          } else {
                result(["success": false, "method": "getActivity", "message" : "Invalid Call Arguments"])
          }
     }
    
     func getAthlete(){
       terraClient?.getAthlete()
     }
    
    // Helper
    
    func parseIso8601Date(dateString: String?) -> Date? {
        let newFormatter = ISO8601DateFormatter()
        let parsedDate = newFormatter.date(from: dateString ?? "")
        return parsedDate
    }
      
}
