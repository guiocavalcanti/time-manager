# Time manager

The time manager is a HTTP REST API which schedules HTTP requests to happen any given time in the future. You can also schedule requests to be issued periodically.

## Quickstart

Issuing a HTTP POST request to http://glowing-journey-9050.herokuapp.com/notifications with de following parameters URL encoded:

```
url=http://google.com&periodicity=daily&params&q=test
```

It'll generate a HTTP GET request every 24 hours to to google.com searching for the keyword *test*.

You can also use a graphical HTTP client such as [Chrome REST Console](https://chrome.google.com/webstore/detail/cokgbflfommojglbmbpenpphppikmonn) or [Dev HTTP Client](https://chrome.google.com/webstore/detail/aejoelaoggembcahagimdiliamlcdmfm). There are a lot of [chrome plugins](https://chrome.google.com/webstore/search/http%20client) to help you use HTTP REST services.


### Accepted content types

The time manager is able to process and return the following content types:

- application/xml
- application/json
- application/x-www-form-urlencoded

You just have to set the Content-type and Accept HTTP headers properly.

## Documentation

### POST /notifications

Schedules a HTTP notification (ie request) to happen periodically.

#### Parameters:

- ``url``: the host URL
- ``method``: the HTTP method used (*default*: POST)
- ``content_type``: the content type accepted by the host (*default*: application/xml)
- ``periodicity``: time interval the requests will be sent (*default*: daily). You can also use keywords such as "daily", "hourly", "minutely"
- ``params``: the parameters sent to the server. For example, for ``application/x-www-form-urlencoded`` it could be ``todo[description]=some_text``

**Expected HTTP code**: 201 (created) or 422 unproccesable entity

**Request example:**

```bash
curl http://glowing-journey-9050.herokuapp.com/notifications -d "url=http://google.com&method=post"
```

**Response example:**

```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <notification>
    <content-type>application/xml</content-type>
    <created-at type="datetime">2012-04-10T22:25:40Z</created-at>
    <id type="integer">8</id>
    <method>get</method>
    <params nil="true"></params>
    <periodicity>daily</periodicity>
    <updated-at type="datetime">2012-04-10T22:25:40Z</updated-at>
    <url>http://todoing.heroku.com/</url>
  </notification>
```

### GET /notifications/:id

**Parameters**: N/A

**Expected HTTP code**: 200 (founded) or 404 (not found)

**Request example:**

```bash
curl http://glowing-journey-9050.herokuapp.com/notifications/31
```

**Response example:**

```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <notification>
    <content-type>application/xml</content-type>
    <created-at type="datetime">2012-04-10T22:25:40Z</created-at>
    <id type="integer">8</id>
    <method>get</method>
    <params nil="true"></params>
    <periodicity>daily</periodicity>
    <updated-at type="datetime">2012-04-10T22:25:40Z</updated-at>
    <url>http://todoing.heroku.com/</url>
  </notification>
```
### DELETE /notifications/:id

**Parameters**: N/A

**Expected HTTP code**: 204 (if deleted) or 404 (not found)

**Request example:**

```bash
curl http://glowing-journey-9050.herokuapp.com/notifications/31 -X DELETE
```

**Response example:** N/A (empty body)


## Internals

## Viewing the queue

All the notifications are enqueued on database and processed at a given time by a background job. The queue of scheduled notifications is accessible through this [address](http://glowing-journey-9050.herokuapp.com/schedules). It's also possible to reenqueue or delete enqueued notifications.
