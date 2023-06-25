//
//  File.swift
//  
//
//  Created by Kim SungHun on 2023/05/10.
//

import Foundation
import RealmSwift
import CoreLocation

protocol Realmable {
  func createProfile(profile: Profile, completion: @escaping (() -> Void)) throws -> Void
    func readPetType() -> String
    func readProfileImage() -> Data
    func readName() -> String
    func readBackgroundImage() -> Data
    func readCoordinate() -> CLLocation
    func updatePetType(newPetType: String) throws -> Void
    func updateName(newName: String) throws -> Void
    func updateProfileImage(newProfileImage: Data) throws -> Void
    func updateBackgroundImage(newBackgroundImage: Data) throws -> Void
    func updateCoordinate(newCoordinate: CLLocation) throws -> Void
}

public class RealmManager: Realmable {
    
    public static let shared = RealmManager()
    private var realm: Realm {
        do {
            return try Realm()
        } catch let error as NSError {
            print(error.debugDescription)
            fatalError("Can't continue further, no Realm available")
        }
    }
    
  public func createProfile(profile: Profile, completion: @escaping (() -> Void)) throws {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        do {
			let realm = try Realm()
            try realm.write {
                realm.deleteAll()
                realm.add(profile)
              completion()
            }
        } catch _ {
            throw RealmError.createProfile
        }
    }
    
    public func getUserDatas() -> [Profile] {
        Array(realm.objects(Profile.self))
    }
    
    public func readPetType() -> String {
        realm.objects(Profile.self).first!.value(forKeyPath: "petType")! as! String
    }
    
    public func readName() -> String {
        realm.objects(Profile.self).first!.value(forKeyPath: "name")! as! String
    }
    
    public func readProfileImage() -> Data {
        realm.objects(Profile.self).first!.value(forKeyPath: "profileImage")! as! Data
    }
    
    public func readBackgroundImage() -> Data {
        realm.objects(Profile.self).first!.value(forKeyPath: "backgroundImage")! as! Data
    }
    
    public func readCoordinate() -> CLLocation {
        let latitude = realm.objects(Profile.self).first!.value(forKeyPath: "latitude")! as! Double
        let longitude = realm.objects(Profile.self).first!.value(forKeyPath: "longitude")! as! Double
        let location = CLLocation(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        return location
    }
    
    public func updatePetType(newPetType: String) throws {
        let petType = RealmManager.shared.readPetType()
        
        if let update = realm.objects(Profile.self).filter(
            NSPredicate(format: "petType = %@", petType)
        ).first {
            do {
                try realm.write {
                    update.petType = newPetType
                }
            } catch _ {
                throw RealmError.updatePetType
            }
        }
    }
    
    public func updateName(newName: String) throws {
        let name = RealmManager.shared.readName()
        if let update = realm.objects(Profile.self).filter(
            NSPredicate(format: "name = %@", name)
        ).first {
            do {
                try realm.write {
                    update.name = newName
                }
            } catch _ {
                throw RealmError.updateName
            }
        }
    }
    
    public func updateProfileImage(newProfileImage: Data) throws {
        let profileImage = RealmManager.shared.readProfileImage() as CVarArg
        if let update = realm.objects(Profile.self).filter(
            NSPredicate(format: "profileImage = %@", profileImage)
        ).first {
            do {
                try realm.write {
                    update.profileImage = newProfileImage
                }
            } catch _ {
                throw RealmError.updateProfileImage
            }
        }
    }
    
    public func updateBackgroundImage(newBackgroundImage: Data) throws {
        let backgroundImage = RealmManager.shared.readBackgroundImage() as CVarArg
        if let update = realm.objects(Profile.self).filter(
            NSPredicate(format: "backgroundImage = %@", backgroundImage)
        ).first {
            do {
                try realm.write {
                    update.backgroundImage = newBackgroundImage
                }
            } catch _ {
                throw RealmError.updateBackgroundImage
            }
        }
    }
    
    public func updateCoordinate(newCoordinate: CLLocation) throws {
        let latitude = RealmManager.shared.readCoordinate().coordinate.latitude
        if let updateLatitude = realm.objects(Profile.self).filter(
            NSPredicate(format: "latitude = %@", latitude)
        ).first {
            do {
                try realm.write {
                    updateLatitude.latitude = newCoordinate.coordinate.latitude
                }
            } catch _ {
                throw RealmError.updateCoordinate
            }
        }
        
        let longitude = RealmManager.shared.readCoordinate().coordinate.longitude
        if let updateLongitude = realm.objects(Profile.self).filter(
            NSPredicate(format: "longitude = %@", longitude)
        ).first {
            do {
                try realm.write {
                    updateLongitude.latitude = newCoordinate.coordinate.longitude
                }
            } catch _ {
                throw RealmError.updateCoordinate
            }
        }
    }
}
