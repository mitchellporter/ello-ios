//
//  ActivitySpec.swift
//  Ello
//
//  Created by Sean Dougherty on 12/1/14.
//  Copyright (c) 2014 Ello. All rights reserved.
//

import Ello
import Quick
import Nimble


class ActivitySpec: QuickSpec {
    override func spec() {
        context("notification Kinds") {
            context("Kind.commentNotifications()") {
                it("should only contain notification kinds") {
                    let allNotificationKinds = Activity.Kind.allNotifications()
                    for kind in Activity.Kind.commentNotifications() {
                        expect(allNotificationKinds.map { return $0.rawValue }).to(contain(kind.rawValue))
                    }
                }
            }
            context("Kind.mentionNotifications()") {
                it("should only contain notification kinds") {
                    let allNotificationKinds = Activity.Kind.allNotifications()
                    for kind in Activity.Kind.mentionNotifications() {
                        expect(allNotificationKinds.map { return $0.rawValue }).to(contain(kind.rawValue))
                    }
                }
            }
            context("Kind.repostNotifications()") {
                it("should only contain notification kinds") {
                    let allNotificationKinds = Activity.Kind.allNotifications()
                    for kind in Activity.Kind.repostNotifications() {
                        expect(allNotificationKinds.map { return $0.rawValue }).to(contain(kind.rawValue))
                    }
                }
            }
            context("Kind.relationshipNotifications()") {
                it("should only contain notification kinds") {
                    let allNotificationKinds = Activity.Kind.allNotifications()
                    for kind in Activity.Kind.relationshipNotifications() {
                        expect(allNotificationKinds.map { return $0.rawValue }).to(contain(kind.rawValue))
                    }
                }
            }
            context("joining all filters") {
                it("should contain all the notification kinds") {
                    let allNotificationKinds = Activity.Kind.allNotifications()
                    let filteredNotificationKinds = Activity.Kind.commentNotifications() + Activity.Kind.mentionNotifications() + Activity.Kind.repostNotifications() + Activity.Kind.relationshipNotifications()
                    for kind in allNotificationKinds {
                        expect(filteredNotificationKinds.map { return $0.rawValue }).to(contain(kind.rawValue))
                    }
                }
            }
        }
        describe("+fromJSON:") {

            context("friend stream") {
                it("parses own post correctly") {
                    let parsedActivities = stubbedJSONDataArray("activity_streams_friend_stream", "activities")
                    let activity = Activity.fromJSON(parsedActivities[0]) as! Activity
                    let createdAtStr = "2014-06-03T00:00:00.000Z"
                    let createdAt: NSDate = createdAtStr.toNSDate()!
                    // active record
                    expect(activity.id) == createdAtStr
                    expect(activity.createdAt) == createdAt
                    // required
                    expect(activity.kind) == Activity.Kind.OwnPost
                    expect(activity.subjectType) == Activity.SubjectType.Post
                    // links
                    expect(activity.subject).to(beAKindOf(Post.self))
                }

                it("parses friend post correctly") {
                    let parsedActivities = stubbedJSONDataArray("activity_streams_friend_stream", "activities")
                    let activity = Activity.fromJSON(parsedActivities[1]) as! Activity
                    let createdAtStr = "2014-06-02T00:00:00.000Z"
                    let createdAt: NSDate = createdAtStr.toNSDate()!
                    // active record
                    expect(activity.id) == createdAtStr
                    expect(activity.createdAt) == createdAt
                    // required
                    expect(activity.kind) == Activity.Kind.FriendPost
                    expect(activity.subjectType) == Activity.SubjectType.Post
                    // links
                    expect(activity.subject).to(beAKindOf(Post.self))
                }

                it("parses welcome post correctly") {
                    let parsedActivities = stubbedJSONDataArray("activity_streams_friend_stream", "activities")
                    let activity = Activity.fromJSON(parsedActivities[2]) as! Activity
                    let createdAtStr = "2014-06-01T00:00:00.000Z"
                    let createdAt: NSDate = createdAtStr.toNSDate()!
                    // active record
                    expect(activity.id) == createdAtStr
                    expect(activity.createdAt) == createdAt
                    // required
                    expect(activity.kind) == Activity.Kind.WelcomePost
                    expect(activity.subjectType) == Activity.SubjectType.User
                    // links
                    expect(activity.subject).to(beAKindOf(User.self))
                }
            }
        }

        context("NSCoding") {

            var filePath = ""

            beforeEach {
                filePath = NSFileManager.ElloDocumentsDir().stringByAppendingPathComponent("ActivitySpec")
            }

            afterEach {
                var error:NSError?
                NSFileManager.defaultManager().removeItemAtPath(filePath, error: &error)
            }

            context("encoding") {

                it("encodes successfully") {
                    let activity: Activity = stub([:])
                    let wasSuccessfulArchived = NSKeyedArchiver.archiveRootObject(activity, toFile: filePath)
                    expect(wasSuccessfulArchived).to(beTrue())
                }
            }

            context("decoding") {

                it("decodes own post successfully") {
                    let expectedCreatedAt = NSDate()
                    let post: Post = stub(["id" : "768"])
                    let activity: Activity = stub([
                        "subject" : post,
                        "id" : "456",
                        "kind" : "own_post",
                        "subjectType" : "Post",
                        "createdAt" : expectedCreatedAt
                    ])

                    NSKeyedArchiver.archiveRootObject(activity, toFile: filePath)
                    let unArchivedActivity = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as! Activity

                    expect(unArchivedActivity).toNot(beNil())
                    expect(unArchivedActivity.version) == 1
                    // active record
                    expect(unArchivedActivity.id) == "456"
                    expect(unArchivedActivity.createdAt) == expectedCreatedAt
                    // required
                    expect(unArchivedActivity.kind) == Activity.Kind.OwnPost
                    expect(unArchivedActivity.subjectType) == Activity.SubjectType.Post
                    // links
                    let unArchivedPost = unArchivedActivity.subject as! Post
                    expect(unArchivedPost).to(beAKindOf(Post.self))
                    expect(unArchivedPost.id) == "768"
                }

                it("decodes friend post successfully") {
                    let expectedCreatedAt = NSDate()
                    let post: Post = stub(["id" : "768"])
                    let activity: Activity = stub([
                        "subject" : post,
                        "id" : "456",
                        "kind" : "friend_post",
                        "subjectType" : "Post",
                        "createdAt" : expectedCreatedAt
                        ])

                    NSKeyedArchiver.archiveRootObject(activity, toFile: filePath)
                    let unArchivedActivity = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as! Activity

                    expect(unArchivedActivity).toNot(beNil())
                    expect(unArchivedActivity.version) == 1
                    // active record
                    expect(unArchivedActivity.id) == "456"
                    expect(unArchivedActivity.createdAt) == expectedCreatedAt
                    // required
                    expect(unArchivedActivity.kind) == Activity.Kind.FriendPost
                    expect(unArchivedActivity.subjectType) == Activity.SubjectType.Post
                    // links
                    let unArchivedPost = unArchivedActivity.subject as! Post
                    expect(unArchivedPost).to(beAKindOf(Post.self))
                    expect(unArchivedPost.id) == "768"
                }

                it("decodes welcome post successfully") {
                    let expectedCreatedAt = NSDate()
                    let user: User = stub(["id" : "768"])
                    let activity: Activity = stub([
                        "subject" : user,
                        "id" : "456",
                        "kind" : "welcome_post",
                        "subjectType" : "User",
                        "createdAt" : expectedCreatedAt
                        ])

                    NSKeyedArchiver.archiveRootObject(activity, toFile: filePath)
                    let unArchivedActivity = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as! Activity

                    expect(unArchivedActivity).toNot(beNil())
                    expect(unArchivedActivity.version) == 1
                    // active record
                    expect(unArchivedActivity.id) == "456"
                    expect(unArchivedActivity.createdAt) == expectedCreatedAt
                    // required
                    expect(unArchivedActivity.kind) == Activity.Kind.WelcomePost
                    expect(unArchivedActivity.subjectType) == Activity.SubjectType.User
                    // links
                    let unArchivedUser = unArchivedActivity.subject as! User
                    expect(unArchivedUser).to(beAKindOf(User.self))
                    expect(unArchivedUser.id) == "768"
                }

                it("decodes noise post successfully") {
                    let expectedCreatedAt = NSDate()
                    let post: Post = stub(["id" : "768"])
                    let activity: Activity = stub([
                        "subject" : post,
                        "id" : "456",
                        "kind" : "noise_post",
                        "subjectType" : "Post",
                        "createdAt" : expectedCreatedAt
                    ])

                    NSKeyedArchiver.archiveRootObject(activity, toFile: filePath)
                    let unArchivedActivity = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as! Activity

                    expect(unArchivedActivity).toNot(beNil())
                    expect(unArchivedActivity.version) == 1
                    // active record
                    expect(unArchivedActivity.id) == "456"
                    expect(unArchivedActivity.createdAt) == expectedCreatedAt
                    // required
                    expect(unArchivedActivity.kind) == Activity.Kind.NoisePost
                    expect(unArchivedActivity.subjectType) == Activity.SubjectType.Post
                    // links
                    let unArchivedPost = unArchivedActivity.subject as! Post
                    expect(unArchivedPost).to(beAKindOf(Post.self))
                    expect(unArchivedPost.id) == "768"
                }
            }
        }
    }
}

