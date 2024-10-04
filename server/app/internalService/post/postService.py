from datetime import datetime, timezone
from pymongo.collection import Collection
from bson import ObjectId
from app.model.postModel import PostData, ReplyData

class PostService:
    def __init__(self, dbCollection: Collection):
        self.posts_collection = dbCollection["posts"]
        self.reply_collection = dbCollection["reply"]

    def create_post(self, data: PostData):
        post_document = {
            "name": data.name,
            "age": data.age,
            "weight": data.weight,
            "gender": data.gender,
            "address": data.address,
            "reward": data.reward,
            "createdAt": datetime.now(timezone.utc),
            "updatedAt": datetime.now(timezone.utc)
        }

        try:
            result = self.posts_collection.insert_one(post_document)
            if result.inserted_id:
                return {"message": "Post created successfully.", "post_id": str(result.inserted_id)}
            else:
                return {"message": "Failed to create post."}
        except Exception as e:
            raise Exception(f"An error occurred while creating the post: {str(e)}")

    def reply_post(self,data: ReplyData):
        reply_document = {
            "address": data.address,
            "detail": data.detail,
            "createdAt": datetime.now(timezone.utc),
            "updatedAt": datetime.now(timezone.utc)
        }


        try:
            result = self.reply_collection.insert_one(reply_document)
            if result.inserted_id:
                return {"message": "Reply created successfully.", "reply_id": str(result.inserted_id)}
            else:
                return {"message": "Failed to reply post."}
        except Exception as e:
            raise Exception(f"An error occurred while replying the post: {str(e)}")
        


    def get_posts(self):
        try:
            posts = list(self.posts_collection.find())
            for post in posts:
                post["_id"] = str(post["_id"])
            return posts
        except Exception as e:
            raise Exception(f"An error occurred while fetching posts: {str(e)}")


    def get_post_by_id(self, post_id: str):
        try:
            
            post = self.posts_collection.find_one({"_id": ObjectId(post_id)})
            if post:
                post["_id"] = str(post["_id"])
                return post
            else:
                return {"message": "Post not found"}
        except Exception as e:
            raise Exception(f"An error occurred while fetching the post: {str(e)}")


    def get_replies(self):
        try:
            replies = list(self.reply_collection.find())
            for reply in replies:
                reply["_id"] = str(reply["_id"])
            return replies
        except Exception as e:
            raise Exception(f"An error occurred while fetching repliess: {str(e)}")


    def get_reply_by_id(self, reply_id: str):
        try:
            
            reply = self.reply_collection.find_one({"_id": ObjectId(reply_id)})
            if reply:
                reply["_id"] = str(reply["_id"])
                return reply
            else:
                return {"message": "Reply not found"}
        except Exception as e:
            raise Exception(f"An error occurred while fetching the reply: {str(e)}")