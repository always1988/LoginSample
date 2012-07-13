//
//  Created by cybo on 7/12/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "LSAuthenticator.h"
#import "LSUser.h"

static LSAuthenticator *_sharedAuthenticator;

@implementation LSAuthenticator{
    @private
    NSDictionary *_users;
}
@synthesize users = _users;

+(LSAuthenticator *)sharedAuthenticator {
    @synchronized (self) {
        if (_sharedAuthenticator == nil){
            _sharedAuthenticator = [[self alloc] init];
            NSMutableDictionary *myUsers = [[NSMutableDictionary alloc] init];
            LSUser *me = [[LSUser alloc] initWithUsername:@"cybo42@gmail.com" password:@"password123"];

            [myUsers setObject:me forKey:me.username];
            [me release];

            LSUser *admin = [[LSUser alloc] initWithUsername:@"admin@example.com" password:@"admin"];
            [myUsers setObject:admin forKey:admin.username];
            [admin release];

            _sharedAuthenticator.users = myUsers;
            [myUsers release];
        }
    }

    return _sharedAuthenticator;
}

- (LSUser *)authenticateUsername:(NSString *)username withPassword :(NSString *)password {
    LSUser *testUser = [self.users objectForKey:username];
    if ([testUser.password isEqualToString:password]){
        return testUser;
    }

    return nil;
}


- (void)dealloc {
    [_users release];
    [super dealloc];
}

@end