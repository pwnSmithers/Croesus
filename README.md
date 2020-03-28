# Croesus
Croesus is a Fintech company that works to improve financial wellness of its customers. We have a complex solution for collecting, extracting, crunching and  analysing the financial data of our customers and providing useful feedback to improve the customer’s financial health.


Dependencies
-  pod 'Firebase/Core', :inhibit_warnings => true
- pod 'Firebase/Database', :inhibit_warnings => true
- pod 'Firebase/Auth', :inhibit_warnings => true
- pod 'SWActivityIndicatorView'
- pod 'Firebase/Storage'
- pod 'Firebase/Firestore'
- pod 'KeychainAccess'    
- pod 'ResearchKit'

Usage
- Download zipped copy of project from GitHub
- unpack it into local development folder
- open terminal , run command $ pod install
- Croesus.xcworkspace run file
- open xCode
- Build to device of choice i.e Iphone 11 pro
- Register account
- Take surveys if availble 


Architectural pattern 
- MVC is central to a good design for a Cocoa application. The benefits of adopting this pattern are numerous. Many objects in these applications tend to be more reusable, and their interfaces tend to be better defined. Applications having an MVC design are also more easily extensible than other applications. Moreover, many Cocoa technologies and architectures are based on MVC and required that my custom objects play one of the MVC roles.


Testing:
- i used Quick + Nimble to write some basic tests

TO DO List:
-I intend to implement behaviour driven testing with quick + nimble Modularize the code a bit more(The main view controller is a bit congested) Introduce some RxSwift(this is something I've been learning) Provide more protection for the API Key, its currently unsafe Introduce ability to switch between layouts i.e Staggered, list and Grid.
