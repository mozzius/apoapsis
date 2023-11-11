//
//  TestPosts.swift
//  Apoapsis
//
//  Created by Samuel Newman on 11/11/2023.
//

import Foundation
import ATProto

func getTestPost() -> ATProto.App.Bsky.Feed.Defs.FeedViewPost? {
    let json = #"""
{
    "post": {
        "uri": "at://did:plc:p2cp5gopk7mgjegy6wadk3ep/app.bsky.feed.post/3kdtgqjirl52c",
        "cid": "bafyreidbkeuwxf7y7bzua7re65tpuw357yla6n4j4pxkez7mkdwqwri3ny",
        "author": {
            "did": "did:plc:p2cp5gopk7mgjegy6wadk3ep",
            "handle": "mozzius.dev",
            "displayName": "Fracture Considered Armful",
            "avatar": "https://cdn.bsky.app/img/avatar/plain/did:plc:p2cp5gopk7mgjegy6wadk3ep/bafkreifcop6pq373zewdqczka7f6f6553m74cm335p32ldrw2piv372t2i@jpeg",
            "viewer": {
                "muted": false,
                "blockedBy": false
            },
            "labels": []
        },
        "record": {
            "text": "Ok this is a banger app logo I won’t lie\n\n(don’t get excited, I’m just messing around with SwiftUI)",
            "$type": "app.bsky.feed.post",
            "embed": {
                "$type": "app.bsky.embed.images",
                "images": [
                    {
                        "alt": "App called Apoapsis\n\nIcon is a @ symbol in a planet with a starry backdrop",
                        "image": {
                            "$type": "blob",
                            "ref": {
                                "$link": "bafkreifcducruexy7jtjcn3lncjmais7pts6ulxamsdvidgnfujy7yyg7m"
                            },
                            "mimeType": "image/jpeg",
                            "size": 267048
                        },
                        "aspectRatio": {
                            "width": 1170,
                            "height": 607
                        }
                    }
                ]
            },
            "langs": [
                "en"
            ],
            "createdAt": 1699621300
        },
        "embed": {
            "$type": "app.bsky.embed.images#view",
            "images": [
                {
                    "thumb": "https://cdn.bsky.app/img/feed_thumbnail/plain/did:plc:p2cp5gopk7mgjegy6wadk3ep/bafkreifcducruexy7jtjcn3lncjmais7pts6ulxamsdvidgnfujy7yyg7m@jpeg",
                    "fullsize": "https://cdn.bsky.app/img/feed_fullsize/plain/did:plc:p2cp5gopk7mgjegy6wadk3ep/bafkreifcducruexy7jtjcn3lncjmais7pts6ulxamsdvidgnfujy7yyg7m@jpeg",
                    "alt": "App called Apoapsis\n\nIcon is a @ symbol in a planet with a starry backdrop",
                    "aspectRatio": {
                        "width": 1170,
                        "height": 607
                    }
                }
            ]
        },
        "replyCount": 2,
        "repostCount": 0,
        "likeCount": 6,
        "indexedAt": 1699621300,
        "viewer": {},
        "labels": []
    }
}
"""#.data(using: .utf8)!
    let decoder = JSONDecoder()
    do {
        return try decoder.decode(ATProto.App.Bsky.Feed.Defs.FeedViewPost.self, from: json)
    } catch {
        print(error)
        return nil
    }
}

func getTestPostWith2Images() -> ATProto.App.Bsky.Feed.Defs.FeedViewPost? {
    let json = #"""
{
    "post": {
        "uri": "at://did:plc:p2cp5gopk7mgjegy6wadk3ep/app.bsky.feed.post/3kdw24xno7z24",
        "cid": "bafyreie6okwlu6zhbqwyj6po3vkg73olnux347usdrc2ggij6va3yebqvu",
        "author": {
            "did": "did:plc:p2cp5gopk7mgjegy6wadk3ep",
            "handle": "mozzius.dev",
            "displayName": "Fracture Considered Armful",
            "avatar": "https://cdn.bsky.app/img/avatar/plain/did:plc:p2cp5gopk7mgjegy6wadk3ep/bafkreifcop6pq373zewdqczka7f6f6553m74cm335p32ldrw2piv372t2i@jpeg",
            "viewer": {
                "muted": false,
                "blockedBy": false
            },
            "labels": []
        },
        "record": {
            "text": "Yeah probably - I just wish I could do it natively. NavigationSplitView gracefully converts into this on small screens with zero extra config needed",
            "$type": "app.bsky.feed.post",
            "embed": {
                "$type": "app.bsky.embed.images",
                "images": [
                    {
                        "alt": "",
                        "image": {
                            "$type": "blob",
                            "ref": {
                                "$link": "bafkreidxodjasdysim4fplft56wu7s2r5ryasew3k2fbmbbjg3ki2oaol4"
                            },
                            "mimeType": "image/jpeg",
                            "size": 194511
                        },
                        "aspectRatio": {
                            "width": 624,
                            "height": 1188
                        }
                    },
                    {
                        "alt": "",
                        "image": {
                            "$type": "blob",
                            "ref": {
                                "$link": "bafkreiboxjevihxfo4jkx6gnq5zijq2a6llp7vx5tx2hsh65uwj36g54nm"
                            },
                            "mimeType": "image/jpeg",
                            "size": 327276
                        },
                        "aspectRatio": {
                            "width": 628,
                            "height": 1188
                        }
                    }
                ]
            },
            "langs": [
                "en"
            ],
            "reply": {
                "root": {
                    "cid": "bafyreiejhsoapgqublzynqs55cgomof4euseav7hnt7r52zoiretzwztje",
                    "uri": "at://did:plc:p2cp5gopk7mgjegy6wadk3ep/app.bsky.feed.post/3kdvxydafbl2n"
                },
                "parent": {
                    "cid": "bafyreig2kxber2icolbeomexnvej5jfjhk4cor3ojb4uch5kwnnreygcau",
                    "uri": "at://did:plc:w342borqxtyo2pul67ec2pwt/app.bsky.feed.post/3kdvzydqvxc2j"
                }
            },
            "createdAt": 1699621300
        },
        "embed": {
            "$type": "app.bsky.embed.images#view",
            "images": [
                {
                    "thumb": "https://cdn.bsky.app/img/feed_thumbnail/plain/did:plc:p2cp5gopk7mgjegy6wadk3ep/bafkreidxodjasdysim4fplft56wu7s2r5ryasew3k2fbmbbjg3ki2oaol4@jpeg",
                    "fullsize": "https://cdn.bsky.app/img/feed_fullsize/plain/did:plc:p2cp5gopk7mgjegy6wadk3ep/bafkreidxodjasdysim4fplft56wu7s2r5ryasew3k2fbmbbjg3ki2oaol4@jpeg",
                    "alt": "",
                    "aspectRatio": {
                        "width": 624,
                        "height": 1188
                    }
                },
                {
                    "thumb": "https://cdn.bsky.app/img/feed_thumbnail/plain/did:plc:p2cp5gopk7mgjegy6wadk3ep/bafkreiboxjevihxfo4jkx6gnq5zijq2a6llp7vx5tx2hsh65uwj36g54nm@jpeg",
                    "fullsize": "https://cdn.bsky.app/img/feed_fullsize/plain/did:plc:p2cp5gopk7mgjegy6wadk3ep/bafkreiboxjevihxfo4jkx6gnq5zijq2a6llp7vx5tx2hsh65uwj36g54nm@jpeg",
                    "alt": "",
                    "aspectRatio": {
                        "width": 628,
                        "height": 1188
                    }
                }
            ]
        },
        "replyCount": 3,
        "repostCount": 0,
        "likeCount": 3,
        "indexedAt": 1699621300,
        "viewer": {},
        "labels": []
    }
}
"""#.data(using: .utf8)!
    let decoder = JSONDecoder()
    do {
        return try decoder.decode(ATProto.App.Bsky.Feed.Defs.FeedViewPost.self, from: json)
    } catch {
        print(error)
        return nil
    }
}


func getTestPostWith3Images() -> ATProto.App.Bsky.Feed.Defs.FeedViewPost? {
    let json = #"""
{
    "post": {
        "uri": "at://did:plc:p2cp5gopk7mgjegy6wadk3ep/app.bsky.feed.post/3kcq5oacszv24",
        "cid": "bafyreigwm4hq4eyjenmjoqw5mlcsolpewkac2smjjwjhwcbzhxerzfrsue",
        "author": {
            "did": "did:plc:p2cp5gopk7mgjegy6wadk3ep",
            "handle": "mozzius.dev",
            "displayName": "Fracture Considered Armful",
            "avatar": "https://cdn.bsky.app/img/avatar/plain/did:plc:p2cp5gopk7mgjegy6wadk3ep/bafkreifcop6pq373zewdqczka7f6f6553m74cm335p32ldrw2piv372t2i@jpeg",
            "viewer": {
                "muted": false,
                "blockedBy": false
            },
            "labels": []
        },
        "record": {
            "text": "Coming soon: proper hashtag feeds, powered by @skyfeed.xyz\n\ncc @redsolver.dev - thank you so much!!",
            "$type": "app.bsky.feed.post",
            "embed": {
                "$type": "app.bsky.embed.images",
                "images": [
                    {
                        "alt": "feed for #hashtag, sorting by new",
                        "image": {
                            "$type": "blob",
                            "ref": {
                                "$link": "bafkreif62b7sdnflwebbtw5pqu3xp35ugaxih6zfqvqkcv224tqthuk2se"
                            },
                            "mimeType": "image/jpeg",
                            "size": 416618
                        },
                        "aspectRatio": {
                            "width": 923,
                            "height": 2000
                        }
                    },
                    {
                        "alt": "feed for #hashtag, sorting by Top (24h)",
                        "image": {
                            "$type": "blob",
                            "ref": {
                                "$link": "bafkreid5jtjw2mwoxivhnjbfqoee3c5pjbxogyszzsrafphstshu5kovua"
                            },
                            "mimeType": "image/jpeg",
                            "size": 627931
                        },
                        "aspectRatio": {
                            "width": 923,
                            "height": 2000
                        }
                    },
                    {
                        "alt": "Action sheet with the options New, Hot, Rising, Top (10h), Top (24h), Top (3d), Top (7d), Random",
                        "image": {
                            "$type": "blob",
                            "ref": {
                                "$link": "bafkreigktxze3pnsubu5ed4pf5m3enos3njynfkhoggw7j7dvdj3yqu52q"
                            },
                            "mimeType": "image/jpeg",
                            "size": 223141
                        },
                        "aspectRatio": {
                            "width": 923,
                            "height": 2000
                        }
                    }
                ]
            },
            "langs": [
                "en"
            ],
            "facets": [
                {
                    "$type": "app.bsky.richtext.facet",
                    "index": {
                        "byteEnd": 58,
                        "byteStart": 46
                    },
                    "features": [
                        {
                            "did": "did:plc:tenurhgjptubkk5zf5qhi3og",
                            "$type": "app.bsky.richtext.facet#mention"
                        }
                    ]
                },
                {
                    "$type": "app.bsky.richtext.facet",
                    "index": {
                        "byteEnd": 77,
                        "byteStart": 63
                    },
                    "features": [
                        {
                            "did": "did:plc:odo2zkpujsgcxtz7ph24djkj",
                            "$type": "app.bsky.richtext.facet#mention"
                        }
                    ]
                }
            ],
            "createdAt": 1699621300
        },
        "embed": {
            "$type": "app.bsky.embed.images#view",
            "images": [
                {
                    "thumb": "https://cdn.bsky.app/img/feed_thumbnail/plain/did:plc:p2cp5gopk7mgjegy6wadk3ep/bafkreif62b7sdnflwebbtw5pqu3xp35ugaxih6zfqvqkcv224tqthuk2se@jpeg",
                    "fullsize": "https://cdn.bsky.app/img/feed_fullsize/plain/did:plc:p2cp5gopk7mgjegy6wadk3ep/bafkreif62b7sdnflwebbtw5pqu3xp35ugaxih6zfqvqkcv224tqthuk2se@jpeg",
                    "alt": "feed for #hashtag, sorting by new",
                    "aspectRatio": {
                        "width": 923,
                        "height": 2000
                    }
                },
                {
                    "thumb": "https://cdn.bsky.app/img/feed_thumbnail/plain/did:plc:p2cp5gopk7mgjegy6wadk3ep/bafkreid5jtjw2mwoxivhnjbfqoee3c5pjbxogyszzsrafphstshu5kovua@jpeg",
                    "fullsize": "https://cdn.bsky.app/img/feed_fullsize/plain/did:plc:p2cp5gopk7mgjegy6wadk3ep/bafkreid5jtjw2mwoxivhnjbfqoee3c5pjbxogyszzsrafphstshu5kovua@jpeg",
                    "alt": "feed for #hashtag, sorting by Top (24h)",
                    "aspectRatio": {
                        "width": 923,
                        "height": 2000
                    }
                },
                {
                    "thumb": "https://cdn.bsky.app/img/feed_thumbnail/plain/did:plc:p2cp5gopk7mgjegy6wadk3ep/bafkreigktxze3pnsubu5ed4pf5m3enos3njynfkhoggw7j7dvdj3yqu52q@jpeg",
                    "fullsize": "https://cdn.bsky.app/img/feed_fullsize/plain/did:plc:p2cp5gopk7mgjegy6wadk3ep/bafkreigktxze3pnsubu5ed4pf5m3enos3njynfkhoggw7j7dvdj3yqu52q@jpeg",
                    "alt": "Action sheet with the options New, Hot, Rising, Top (10h), Top (24h), Top (3d), Top (7d), Random",
                    "aspectRatio": {
                        "width": 923,
                        "height": 2000
                    }
                }
            ]
        },
        "replyCount": 5,
        "repostCount": 20,
        "likeCount": 85,
        "indexedAt": 1699621300,
        "viewer": {},
        "labels": []
    }
}
"""#.data(using: .utf8)!
    let decoder = JSONDecoder()
    do {
        return try decoder.decode(ATProto.App.Bsky.Feed.Defs.FeedViewPost.self, from: json)
    } catch {
        print(error)
        return nil
    }
}

func getTestPostWith4Images() -> ATProto.App.Bsky.Feed.Defs.FeedViewPost? {
    let json = #"""
{
    "post": {
        "uri": "at://did:plc:w342borqxtyo2pul67ec2pwt/app.bsky.feed.post/3kce3xrm6gm26",
        "cid": "bafyreiebfleqq6q6mihaawd7pubcmthq7uiqpib5f2clvmnyatkpo63pny",
        "author": {
            "did": "did:plc:w342borqxtyo2pul67ec2pwt",
            "handle": "deck.blue",
            "displayName": "deck.blue",
            "avatar": "https://cdn.bsky.app/img/avatar/plain/did:plc:w342borqxtyo2pul67ec2pwt/bafkreiec6yihxyfgua7myrxcfx75opofiu6l5wm4jzjrn3irlklynmagmy@jpeg",
            "viewer": {
                "muted": false,
                "blockedBy": false,
                "following": "at://did:plc:p2cp5gopk7mgjegy6wadk3ep/app.bsky.graph.follow/3k5kgwcixw225",
                "followedBy": "at://did:plc:w342borqxtyo2pul67ec2pwt/app.bsky.graph.follow/3k5kguodqvm2y"
            },
            "labels": []
        },
        "record": {
            "text": "So happy to reveal deck.blue's new brand identity! \n\nThanks @tullece.bsky.social for your amazing work.",
            "$type": "app.bsky.feed.post",
            "embed": {
                "$type": "app.bsky.embed.images",
                "images": [
                    {
                        "alt": "",
                        "image": {
                            "$type": "blob",
                            "ref": {
                                "$link": "bafkreidhamwf6ecuwpkb75sabz6d4bt2bcnlvqxqtrd23t33miytjubeta"
                            },
                            "mimeType": "image/png",
                            "size": 37803
                        }
                    },
                    {
                        "alt": "",
                        "image": {
                            "$type": "blob",
                            "ref": {
                                "$link": "bafkreied3lnt4cvjuckq2hq5tputcaotv67ofpwleunpejah4dxdrogt64"
                            },
                            "mimeType": "image/png",
                            "size": 41996
                        }
                    },
                    {
                        "alt": "",
                        "image": {
                            "$type": "blob",
                            "ref": {
                                "$link": "bafkreibyevxsjwrtfhrqcvupfnz72qpnqv7gpnuegsbfx6b2tcabpjx7ly"
                            },
                            "mimeType": "image/jpeg",
                            "size": 168670
                        }
                    },
                    {
                        "alt": "",
                        "image": {
                            "$type": "blob",
                            "ref": {
                                "$link": "bafkreibwtckagadk2zlr7hxksz4ydzpdoayukhfav37ii2uleq2c4twugi"
                            },
                            "mimeType": "image/jpeg",
                            "size": 57574
                        }
                    }
                ]
            },
            "langs": [
                "en"
            ],
            "facets": [
                {
                    "index": {
                        "byteEnd": 28,
                        "byteStart": 19
                    },
                    "features": [
                        {
                            "uri": "https://deck.blue",
                            "$type": "app.bsky.richtext.facet#link"
                        }
                    ]
                },
                {
                    "index": {
                        "byteEnd": 80,
                        "byteStart": 60
                    },
                    "features": [
                        {
                            "did": "did:plc:72v6bp7faj6fh6ocaoem7dxf",
                            "$type": "app.bsky.richtext.facet#mention"
                        }
                    ]
                }
            ],
            "createdAt": 1699621300
        },
        "embed": {
            "$type": "app.bsky.embed.images#view",
            "images": [
                {
                    "thumb": "https://cdn.bsky.app/img/feed_thumbnail/plain/did:plc:w342borqxtyo2pul67ec2pwt/bafkreidhamwf6ecuwpkb75sabz6d4bt2bcnlvqxqtrd23t33miytjubeta@jpeg",
                    "fullsize": "https://cdn.bsky.app/img/feed_fullsize/plain/did:plc:w342borqxtyo2pul67ec2pwt/bafkreidhamwf6ecuwpkb75sabz6d4bt2bcnlvqxqtrd23t33miytjubeta@jpeg",
                    "alt": ""
                },
                {
                    "thumb": "https://cdn.bsky.app/img/feed_thumbnail/plain/did:plc:w342borqxtyo2pul67ec2pwt/bafkreied3lnt4cvjuckq2hq5tputcaotv67ofpwleunpejah4dxdrogt64@jpeg",
                    "fullsize": "https://cdn.bsky.app/img/feed_fullsize/plain/did:plc:w342borqxtyo2pul67ec2pwt/bafkreied3lnt4cvjuckq2hq5tputcaotv67ofpwleunpejah4dxdrogt64@jpeg",
                    "alt": ""
                },
                {
                    "thumb": "https://cdn.bsky.app/img/feed_thumbnail/plain/did:plc:w342borqxtyo2pul67ec2pwt/bafkreibyevxsjwrtfhrqcvupfnz72qpnqv7gpnuegsbfx6b2tcabpjx7ly@jpeg",
                    "fullsize": "https://cdn.bsky.app/img/feed_fullsize/plain/did:plc:w342borqxtyo2pul67ec2pwt/bafkreibyevxsjwrtfhrqcvupfnz72qpnqv7gpnuegsbfx6b2tcabpjx7ly@jpeg",
                    "alt": ""
                },
                {
                    "thumb": "https://cdn.bsky.app/img/feed_thumbnail/plain/did:plc:w342borqxtyo2pul67ec2pwt/bafkreibwtckagadk2zlr7hxksz4ydzpdoayukhfav37ii2uleq2c4twugi@jpeg",
                    "fullsize": "https://cdn.bsky.app/img/feed_fullsize/plain/did:plc:w342borqxtyo2pul67ec2pwt/bafkreibwtckagadk2zlr7hxksz4ydzpdoayukhfav37ii2uleq2c4twugi@jpeg",
                    "alt": ""
                }
            ]
        },
        "replyCount": 36,
        "repostCount": 104,
        "likeCount": 511,
        "indexedAt": 1699621300,
        "viewer": {
            "repost": "at://did:plc:p2cp5gopk7mgjegy6wadk3ep/app.bsky.feed.repost/3kce5dd24cu2b",
            "like": "at://did:plc:p2cp5gopk7mgjegy6wadk3ep/app.bsky.feed.like/3kce5dazc3u2x"
        },
        "labels": []
    }
}
"""#.data(using: .utf8)!
    let decoder = JSONDecoder()
    do {
        return try decoder.decode(ATProto.App.Bsky.Feed.Defs.FeedViewPost.self, from: json)
    } catch {
        print(error)
        return nil
    }
}

func getTestPostWithExternal() -> ATProto.App.Bsky.Feed.Defs.FeedViewPost? {
    let json = #"""
{
    "post": {
        "uri": "at://did:plc:jfhpnnst6flqway4eaeqzj2a/app.bsky.feed.post/3kc73spr2ut2g",
        "cid": "bafyreiaqyewlazdrj2tth6mqipr2srr6uroci73xsbaieybsnftjqbrh64",
        "author": {
            "did": "did:plc:jfhpnnst6flqway4eaeqzj2a",
            "handle": "bossett.bsky.social",
            "displayName": "Bossett",
            "avatar": "https://cdn.bsky.app/img/avatar/plain/did:plc:jfhpnnst6flqway4eaeqzj2a/bafkreibj7mlkxjatnihxg7tlwca4rr27savogyqkakfm2fdfz3xdvbz2my@jpeg",
            "viewer": {
                "muted": false,
                "blockedBy": false,
                "following": "at://did:plc:p2cp5gopk7mgjegy6wadk3ep/app.bsky.graph.follow/3k5czjno5jo2z",
                "followedBy": "at://did:plc:jfhpnnst6flqway4eaeqzj2a/app.bsky.graph.follow/3kahzywmnqf2e"
            },
            "labels": []
        },
        "record": {
            "text": "graysky.app is rumoured to have been released today.\n\nThis is a PSA that it's a trap to sneak gifs onto your timeline, and make you use *hashtags*. If we start letting *features* into *apps* where does this end?",
            "$type": "app.bsky.feed.post",
            "embed": {
                "$type": "app.bsky.embed.external",
                "external": {
                    "uri": "https://graysky.app/",
                    "thumb": {
                        "$type": "blob",
                        "ref": {
                            "$link": "bafkreidjyeyhgkfsozuhzfk6mhq4htmilkbukrc26q2ezfvca2obxqjm5a"
                        },
                        "mimeType": "image/jpeg",
                        "size": 751633
                    },
                    "title": "Graysky - a bluesky client",
                    "description": "Experience a whole different skyline."
                }
            },
            "langs": [
                "en"
            ],
            "facets": [
                {
                    "index": {
                        "byteEnd": 11,
                        "byteStart": 0
                    },
                    "features": [
                        {
                            "uri": "https://graysky.app/",
                            "$type": "app.bsky.richtext.facet#link"
                        }
                    ]
                }
            ],
            "createdAt": 1699621300
        },
        "embed": {
            "$type": "app.bsky.embed.external#view",
            "external": {
                "uri": "https://graysky.app/",
                "title": "Graysky - a bluesky client",
                "description": "Experience a whole different skyline.",
                "thumb": "https://cdn.bsky.app/img/feed_thumbnail/plain/did:plc:jfhpnnst6flqway4eaeqzj2a/bafkreidjyeyhgkfsozuhzfk6mhq4htmilkbukrc26q2ezfvca2obxqjm5a@jpeg"
            }
        },
        "replyCount": 4,
        "repostCount": 6,
        "likeCount": 35,
        "indexedAt": 1699621300,
        "viewer": {
            "repost": "at://did:plc:p2cp5gopk7mgjegy6wadk3ep/app.bsky.feed.repost/3kc73u4mw6y2b",
            "like": "at://did:plc:p2cp5gopk7mgjegy6wadk3ep/app.bsky.feed.like/3kc73tnnjzv2w"
        },
        "labels": []
    }
}
"""#.data(using: .utf8)!
    let decoder = JSONDecoder()
    do {
        return try decoder.decode(ATProto.App.Bsky.Feed.Defs.FeedViewPost.self, from: json)
    } catch {
        print(error)
        return nil
    }
}
