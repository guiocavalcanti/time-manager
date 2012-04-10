# Time manager

The time manager is a HTTP REST API which schedules HTTP requests to happen any given time in the future. You can also schedule requests to be issued periodicaly.

## Usage

There is just one resource which represents the requests issued periodicaly.

### POST /notifications

Schedules a HTTP notification (ie request) to happen periodicaly.

#### Parameters:

- ``url``: the host URL
- ``method``: the HTTP method used (*default*: POST)
- ``content_type``: the content type accepted by the host (*default*: application/xml)
- ``periodicity``: time interval the requests will be sent (*default*: daily). You can also use keywords such as "daily", "hourly", "minutely"
- ``params``: the parameters sent to de server. For example, for ``application/x-www-form-urlencoded`` it could be ``todo[description]=some_text``

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

### GET /notifications/<id>

**Parameters**: N/A

**Request example:**

```bash
curl http://0.0.0.0:3000/notifications/31
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
### DELETE /notifications/<id>

**Parameters**: N/A

**Expected HTTP code**: 204 (if deleted) or 404 (if invalid id)

**Request example:**

```bash
curl http://0.0.0.0:3000/notifications/31 -X DELETE
```

**Response example:** N/A (empty body)
