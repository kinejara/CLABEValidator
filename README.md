# CLABEValidator

CLABEValidator is a NSSTring category that will help you to validate CLABE numbers.

CLABE is a mexican standard for the numbering of bank accounts in Mexico,
for more information please refer to [wikipedia].

[wikipedia]: <https://en.wikipedia.org/wiki/CLABE>

# Installation

Just drag and drop the file ``NSString+PNGCLABEValidator.h`` and ``NSString+PNGCLABEValidator.m`` to your project

# Usage

* Import the category to your desire class ``#import "NSString+PNGCLABEValidator.h"``
* Call method ``[NSString isValidCLABE:@"03218000011835971"];``

# TODO
* method to abstract short name and institution name from clabe number
* implementation of NSError to generate error descriptions

# Credits
CLABEValidator is written and maintained by Jorge Villanueva @kinejara.
