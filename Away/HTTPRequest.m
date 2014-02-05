//
//  WebServiceHTTPRequest.m
//  Away
//
//  Created by Marcelo Toledo on 1/31/14.
//  Copyright (c) 2014 Marcelo Toledo. All rights reserved.
//

#import "HTTPRequest.h"

@interface HTTPRequest () <NSURLConnectionDataDelegate, NSURLConnectionDelegate> {
    NSMutableData *_responseData;
    
    NSURLRequest *_request;
    NSURLConnection *_connection;
}

@property(nonatomic,weak) id<HTTPRequestDelegate>delegate;
@property(nonatomic, readwrite) RawHTTPDataType rawHTTPDataType;
@property(nonatomic, readwrite) NSInteger tryCount;

@end

//http://jeffreysambells.com/2013/03/01/asynchronous-operations-in-ios-with-grand-central-dispatch

@implementation HTTPRequest

# pragma mark - Initialization

- (id)init
{
    //
    self = [super init];
    if (self) {
        //
        //_requestManager = [[NSMutableDictionary alloc] init];
        self.tryCount = 0;
    }
    return self;
}

- (id)initWithRequest:(NSURLRequest *)request andDelegate:(id<HTTPRequestDelegate>)delegate
{
    //
    self = [self init];
    if (self) {
        _request = request;
        self.delegate = delegate;
    }
    return self;
}

# pragma mark - NSURLRequest execution

- (void)makeRequestWithExpectedResponseRawHTTPDataType:(RawHTTPDataType)httpDataType
{
    //
    
    if (httpDataType != RawHTTPDataTypeJSON) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"%u not supported. Only RawHTTPDataTypeJson", httpDataType]
                                     userInfo:nil];
    }
    
    self.rawHTTPDataType = RawHTTPDataTypeJSON;
    
    _connection = [NSURLConnection connectionWithRequest:_request delegate:self];
}

- (void)retryRequest
{
    //
    _connection = [NSURLConnection connectionWithRequest:_request delegate:self];
    self.tryCount++;
}

# pragma mark - NSURLConnection Data Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
    
    
    HTTPResponseObject *httpResponse = [HTTPRaw]
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        
        [cell.activityIndicator startAnimating];
        
        photo.thumbnail = [_flickrRequest loadImageForPhoto:photo thumbnail:YES];
        //center
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            cell.photo = photo;
            [self.photosCollectionView reloadItemsAtIndexPaths:@[indexPath]];
        }];
    }];
    
    [_operationQueue addOperation:operation];
    
    
    NSBlockOperation *operation = [[NSBlockOperation alloc] init];
    
    [operation addExecutionBlock:^{
        
        NSMutableArray *photosFetched = [[NSMutableArray alloc] init];
        
        for (NSDictionary *photoDictionary in object){
            [photosFetched addObject:[[FlickrPhoto alloc] initWithDictionary:photoDictionary]];
        }
        
        [[NSOperationQueue  mainQueue] addOperationWithBlock:^{
            _photosFetched = [[_photosFetched arrayByAddingObjectsFromArray:photosFetched] mutableCopy];
            [self.activityIndicator stopAnimating];
            [[self photosCollectionView] reloadData];
        }];
        
    }];
    
    [_operationQueue addOperation:operation];
    
//    NSError *error = nil;
//
//    NSDictionary *parsedData = _responseData ? [NSJSONSerialization JSONObjectWithData:_responseData options:0 error:&error] : nil;
//    
//    if (error)
//    {
//        NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
//        
//        if ([self.delegate respondsToSelector:@selector(request:didFailWithError:)])
//        {
//            [self.delegate request:self didFailWithError:error];
//        }
//        
//        return;
//    }
//    
//    if ([self.delegate respondsToSelector:@selector(request:didFinishWithObject:)])
//    {
//        [self.delegate request:self didFinishWithObject:[self groupData:parsedData  withGroup:@"Mid-Yield"]];
//    }
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // The request has failed for some reason!
    // Check the error var
    
    if ([self.delegate respondsToSelector:@selector(requester:didFailWithError:)])
    {
        [self.delegate requester:self didFailWithError:error];
    }
}

@end
