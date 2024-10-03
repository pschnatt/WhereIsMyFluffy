from bson import ObjectId

def convertObjectIdq(user):
    if isinstance(user, dict):
        for key, value in user.items():
            if isinstance(value, ObjectId):
                user[key] = str(value)
            elif isinstance(value, list):
                user[key] = [str(v) if isinstance(v, ObjectId) else v for v in value]
    return user