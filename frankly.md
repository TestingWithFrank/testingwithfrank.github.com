---
layout: default
title: Frankly
---

Frank consists of two parts, a frank *server* which is embedded into
the iPhone application and a Frank *driver* (such as the ruby one used
by cucumber tests). The driver communicates with the embedded server
via a simple HTTP-based wire protocol called **Frankly**. The protocol
consists of sending GET and POST requests to well-known endpoints, and
processing the response. Request and response bodies may contain JSON
(where appropriate) describing the operation to be performed or the
results of that operation respectively.

## View selectors

An essential part of driving a UI is specifying a subset of UI
elements to act upon. Internally the Frank driver uses a *selector engine* to
select a subset of elements. *Shelley* is the default selector engine that comes with Frank
by default, but you can also plug in other third-party engines.

When a client driver wants to act upon a set of views it sends a *view selector* and a *selector engine* to the server. The view selector is a string representing the selector itself, and the selector engine is just a string telling the Frank server which selector engine to use.

There is more information about how view selectors and view selection engines work [here](/selector_syntax.html).

## Response format

Responses may either be _standard_ or _non-standard_. A standard
response always conforms to a format similar to:

    {
      'outcome': 'SUCCESS',
      'results': ['foo','bar']
    }

In addition, a standard response indicating failure will always conform to a format like:

    {
      'outcome': 'ERROR',
      'reason': 'Failed to frob the flib',
      'detail': 'Flange capacitator decoupled'
    }

Non-standard responses will be valid JSON documents, but nothing else is specified.

## Frankly endpoints 

### GET /dump

Request: A plain old GET. Any query parameters are ignored.

Response: a *non-standard* response describing the current state of
the entire application UI.

### POST /map 

Request: a POST containing a JSON document. The JSON document contains
a UIQuery path, and an optional operation to perform on each element
which matches that path.

Response: a *standard* response containing an array for each element
which matched the path. Each array element represents the result of
applying that operation to the path. For example:
		
    {
      'query': 'tableViewCell marked:\'Touch Me!\'',
      'selector_engine': 'shelley_compat',
      'operation': {
        'method_name': 'touch',
        'arguments': []
      }
    }

Notes: You can use the response to either query the state of the UI,
but you can also use it to confirm that the operation you were
attempting to perform was applied to the correct number of
elements. For example you can check that your attempt to touch an
element was successfully applied to exactly 1 element.

If the driver fails to apply the specified operation to an selected
element then it will place a null in the returned array.

If the driver supplies an invalid view selector then a standard error
response will be returned. However if the driver supplies an invalid
*operation* then the server may simply fail to apply the operation to
each selected element, returning an array filled with nulls, equal to
the number of elements in the subset specified by the UIQuery path.
