
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

/**
 * This extension contains several a helper
 * for creating a sha1 hash from instances of NSString
 */
@interface NSString (Sha1)

/**
 * Creates a SHA1 (hash) representation of NSString.
 *
 * @return NSString
 */
- (NSString *)sha1;


@end
