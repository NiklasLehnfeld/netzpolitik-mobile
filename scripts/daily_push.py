import json
import os

import requests

BASE_URL = 'https://netzpolitik.org'
POSTS_ENDPOINT = BASE_URL + '/wp-json/wp/v2/posts?_embed&page_size=1&page=1'

FIREBASE_URL = 'https://fcm.googleapis.com/fcm/send'


if __name__ == "__main__":
    r = requests.get(POSTS_ENDPOINT)
    article_list = json.loads(r.text)
    last_article = article_list[0]

    title = 'Schon gelesen? 📚'
    subTitle = last_article['title']['rendered']

    post_content = json.dumps({
        'to': '/topics/daily_updates',
        'notification': {
            'title': title,
            'body': subTitle,
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        }
    })

    headers = {
        'Content-Type': 'application/json',
        'Authorization': 'key=' + os.environ['FIREBASE_SERVER_KEY']
    }

    r = requests.post(FIREBASE_URL, data=post_content, headers=headers)
    print(r)