//
//  DataSet.swift
//  CoreDataDemo
//
//  Created by MBA-0019 on 13/03/23.
//

import CoreData


@objc(MyData)


class MyData : NSManagedObject
{
   @NSManaged var name : String!
    @NSManaged   var age : String!
    @NSManaged  var address : String!
    @NSManaged var image : Data?
}
