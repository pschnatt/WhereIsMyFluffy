from fastapi import APIRouter, Request, Response, FastAPI, Depends,HTTPException
from app.core import Core
from app.model.postModel import GetPostById, GetReplyById, PostData,ReplyData
from bson import ObjectId

router = APIRouter()
core = Core()
routerName = "post"

@router.post(f"/{routerName}/createPost/")
def createPost(data: PostData):
    return core.post.create_post(data)


@router.post(f"/{routerName}/replyPost/")
def createReply(data: ReplyData):
    return core.post.reply_post(data)


@router.get(f"/{routerName}/getPosts/")
def get_posts():
    try:
        posts = core.post.get_posts()
        return posts
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    

@router.get(f"/{routerName}/getPost/")
def get_post(post_id: GetPostById):
    try:
        post = core.post.get_post_by_id(post_id)
        if not post:
            raise HTTPException(status_code=404, detail="Post not found.")
        return post
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.get(f"/{routerName}/getReplies/")
def get_replies(post_id: GetPostById):
    try:
        replies = core.post.get_replies(post_id)
        return replies
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    

@router.get(f"/{routerName}/getReply/")
def get_reply(reply_id: GetReplyById):
    try:
        reply = core.post.get_reply_by_id(reply_id)
        if not reply:
            raise HTTPException(status_code=404, detail="Reply not found.")
        return reply
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))