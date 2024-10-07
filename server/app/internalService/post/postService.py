from datetime import datetime, timezone
from pymongo.collection import Collection
from bson import ObjectId
from app.model.postModel import GetPostById, GetReplyById, PostData, ReplyData
from app.internalService.profile.profileService import ProfileService

class PostService:
    def __init__(self, dbCollection: Collection):
        self.posts_collection = dbCollection["posts"]
        self.reply_collection = dbCollection["reply"]
        self.users_collection = dbCollection["users"]


    def create_post(self, data: PostData):
        post_document = {
            "userId" : data.userId,
            "petId" : data.petId,
            "address": data.address,
            "reward": data.reward,
            "createdAt": datetime.now(timezone.utc),
            "updatedAt": datetime.now(timezone.utc),
            "replyIds": []
        }

        try:
            result = self.posts_collection.insert_one(post_document)
            if result.inserted_id:
                user_id = ObjectId(data.userId)
                self.users_collection.update_one(
                    {"_id": user_id},
                    {"$push": {"posts": str(result.inserted_id)}}
                )
                return {"message": "Post created successfully.", "post_id": str(result.inserted_id)}
            else:
                return {"message": "Failed to create post."}
        except Exception as e:
            raise Exception(f"An error occurred while creating the post: {str(e)}")

    def reply_post(self,data: ReplyData):
        reply_document = {
            "postId": data.postId,
            "userId": data.userId,
            "address": data.address,
            "detail": data.detail,
            "createdAt": datetime.now(timezone.utc),
            "updatedAt": datetime.now(timezone.utc)
        }
        try:
            result = self.reply_collection.insert_one(reply_document)
            if result.inserted_id:
                self.posts_collection.update_one(
                    {"_id": data.postId},
                    {"$push": {"replyIds": str(result.inserted_id)}}
                )
                return {"message": "Reply created successfully.", "reply_id": str(result.inserted_id)}
            else:
                return {"message": "Failed to reply to the post."}
        except Exception as e:
            raise Exception(f"An error occurred while replying to the post: {str(e)}")
        

    def get_posts(self):
        try:
            posts = list(self.posts_collection.find({}, {"userId": 1, "petId": 1, "address": 1, "reward": 1}))
            enriched_posts = []
            profileService = ProfileService()
            for post in posts:
                post["_id"] = str(post["_id"]) 
                user = profileService.getUser(post["userId"]) 
                post["user"] = user  
                pet = profileService.getPet(post["petId"]) 
                post["pet"] = pet 
                enriched_posts.append(post) 

            return enriched_posts
        except Exception as e:
            raise Exception(f"An error occurred while fetching posts: {str(e)}")


    def get_post_by_id(self, post_id: GetPostById):
        try:
            
            post = self.posts_collection.find_one({"_id": ObjectId(post_id.postId)})
            if post:
                post["_id"] = str(post["_id"])
                return post
            else:
                return {"message": "Post not found"}
        except Exception as e:
            raise Exception(f"An error occurred while fetching the post: {str(e)}")


    def get_replies(self, postId: GetPostById):
        try:
            replies = list(self.reply_collection.find({"postId": postId.postId}))
            for reply in replies:
                reply["_id"] = str(reply["_id"])
            return replies
        except Exception as e:
            raise Exception(f"An error occurred while fetching replies: {str(e)}")


    def get_reply_by_id(self, reply_id: GetReplyById):
        try:
            reply = self.reply_collection.find_one({"_id": ObjectId(reply_id.replyId)})
            if reply:
                reply["_id"] = str(reply["_id"])
                return reply
            else:
                return {"message": "Reply not found"}
        except Exception as e:
            raise Exception(f"An error occurred while fetching the reply: {str(e)}")