//
//  ViewController.m
//  DemoWKWebView
//
//  Created by Trung Duc on 1/16/18.
//  Copyright © 2018 Trung Duc. All rights reserved.
//

#import "ViewController.h"

#import <WebKit/WebKit.h>

static NSString* const kContentLoadedMessage = @"contentLoaded";

@interface ViewController ()<WKUIDelegate, WKScriptMessageHandler>

@property(nonatomic, strong) WKWebView* webView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  [self configureWebView];
}

- (void)configureWebView {
  NSString* source =
  [NSString stringWithFormat:
   @"var sizeInterval = setInterval("
   "function() {"
   "var h = 0;"
   "var children = document.body.children;"
   "for (var c = 0; c < children.length; c++) {"
   "h += children[c].offsetHeight;"
   "}"
   "if (h > 50) {"
   "clearInterval(sizeInterval);"
   "window.webkit.messageHandlers.%@.postMessage('loaded');"
   "}"
   "},"
   "100);",
   kContentLoadedMessage];

  WKUserScript* script = [[WKUserScript alloc]
                          initWithSource:source
                          injectionTime:WKUserScriptInjectionTimeAtDocumentStart
                          forMainFrameOnly:YES];

  WKUserContentController* contentController =
  [[WKUserContentController alloc] init];
  [contentController addUserScript:script];
  [contentController addScriptMessageHandler:self name:kContentLoadedMessage];

  WKWebViewConfiguration* configuration = [[WKWebViewConfiguration alloc] init];
  configuration.userContentController = contentController;

  self.webView =
  [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
  _webView.UIDelegate = self;
  _webView.opaque = NO;
  _webView.backgroundColor = [UIColor clearColor];
  _webView.scrollView.backgroundColor = [UIColor clearColor];

  [self.view addSubview:_webView];

  _webView.translatesAutoresizingMaskIntoConstraints = NO;
  NSDictionary* views = @{ @"webView" : _webView };
  [self.view addConstraints:[NSLayoutConstraint
                             constraintsWithVisualFormat:@"H:|[webView]|"
                             options:0
                             metrics:nil
                             views:views]];
  [self.view addConstraints:[NSLayoutConstraint
                             constraintsWithVisualFormat:@"V:|[webView]|"
                             options:0
                             metrics:nil
                             views:views]];

  NSString* htmlString = [NSString
                          stringWithFormat:
                          @"<html>"
                          @"<head>"
                          @"<meta name=\"viewport\" content=\"width=device-width, "
                          @"initial-scale=1.0\" />"
                          @"</head>"
                          @"<body style=\"margin: 0px;padding: 0px;\">"
                          @"<img "
                          @"src=\"data:image/"
                          @"png;base64,"
                          @"iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAM7ElEQVR4Xu1bCXBV5R"
                          @"UOA2QjLEKE5L1779uX+"
                          @"7JQtVqnlNa2jjt12mkr0rpMK1oKUTYRaMVB0ULrjKLVioI6FZeKKCHJywsJEDZBA0n"
                          @"emoWwbzUCUijKYu7X89//0mc23n0vCQmdZuab+97Nnf/d7zvnP+f85/"
                          @"43qbf+sNowFIXGPHjFm1Fpuael1j2jpcFRgIjzLsXvGYN6myHpf+"
                          @"0PZdn9USbmo0gYjyLjfJSb3sEW63ql2hlWQu4jSth1gFCrBOViJeJ8jsS4Rwl6bJc3"
                          @"aa90FUrFGYRCsvghFAsgi0PZ4YQSkaE0eqDUE8JuEHGQENHP/"
                          @"DtB3qrU2R5VahzCZULacB0RX0SkIwRgtREoImwg4n4XJ92gkQ5dAJ0P2AG/"
                          @"Bagl0FEJ2EgEl3aNKsjXdHwDYTm/"
                          @"75EuEgZinfgAufhWlbSP4CUUGoE1EpQaJxHPYdbmhKLgpP1Eti4fLTuvRUvTd9iRrh"
                          @"0NkAjwW7kAXCjNS+TXyCNG9QVrJ2NF1iwifZCsDng18iUCJ7/"
                          @"Jykk3tidO4OQarsL5w7fh3Oc/"
                          @"x7mjd+Hs0fHsyL7T+du5EFERogi7Tin+nId6jTyRfpDIHkK5mZPWLK/"
                          @"O8yLCpw4oO8nqdcx9OybfsnsMzpz8Dc78636cPXY3kb+LgX0mTMDZE/"
                          @"fi3LHxmgi2NgJcOMqrUOMYfOmIl4ijUSZtRqnESLdGiUaeBbmmHO0mO0HAjq/3/"
                          @"RDnD96Mll3Xa65/HR2vx9ckDP2PeYYqzvkj4zQvcLUfhwfNQ0rYfk3Pk//"
                          @"Q8BAnLrQlH53zVQ5OPuSOAZlEcAC1Zg6/"
                          @"JRoEtXMI2Emc7+L8oVuZpYmos+OxwjLBybzk+"
                          @"z04342L4ZU0d28HTn6Ljbs9t3zXEWSkrFo2kHWJiqqrftC9xH1iP5SLZSgxdUzep6W"
                          @"6dWYe6SMxbjQxIfRfu2M0sCtrTPeQ/"
                          @"0hKRpFUjRKxM8vzoOcVOYF6jxbwehnV+UDzCFc31OxSLbzRYNep639i567f++"
                          @"QJWiVZPfoodlnTuzDnxXXwCRcjzyu8ClO0nA31IZAXKE2WTYmRL7Qsjml5rczFdgef"
                          @"+8E+JkDYBaUmDwg7Ho+P/Jpht6GMWV7SaX05hvV7WQR/"
                          @"HhDyyPoFKLacRBknGXPub2Nz39PniLevEWzb9ZFfN2IBisyxyZfw2KAEXLzUJQJ9Go"
                          @"FcYI/51hjkM0bCZ2HEYmO1trxt4Nbv8wiyIG3fHyPlZS5FqVm/"
                          @"AFX26CrvckAwB6h3ju9kZSddgTX6yPOiKCH37/"
                          @"3aIOLY2bEA5cJslEj6BCjSyt66Nrk/"
                          @"yIF9HuBkHnCa8HkuwK4JdBcJNxCRgeZc4Kt84N95wG4P6zTpHEMGQjljOxDAuJvnfZ"
                          @"3R/2Nre/ev9wDHc3GuxoWaF0VsWWDE/"
                          @"pVW9Rz28ptMnLh2bPIAn3lwpNCKtXOy8emfBaBBVoVWavWMr3rs+20bl/"
                          @"nwMnI6USRAqXJEA2CYEPEA+1zY+7qA+c4MTM1IwcNpKZg+"
                          @"NAVFBaOYxbilgl1IZXUyjeFA9fxRmDY0FZMHJmPygGQ8e+"
                          @"0QnKxycRECeoKh8xwah0VLZPhMs3ST93KQ2tH5T0Ig5MCZlQYssKRj2rA0LMzLUPGk"
                          @"YxAmJg3ApnkG5rKJC0DehkYHTizLwmMj0zBXSMei0fQb+"
                          @"Rn4XdJAvHnHFcDRXOYNOlKiB2hy3PENASRv+wbHRVZ+"
                          @"5RInEJHVKhDk2qgxYfPDmZgyOBWL6Kb+"
                          @"lMvARXiCRJlrSMOxCjvzhHjJc8vTEX4zvPcNx5QhrX/"
                          @"jaU8GZgxLxd7lZuBEnj4B6hwvcfIV1v5E7DgJoD8Arjdz64c1y2yzAZUi3ho3DDPIO"
                          @"px8FMxSBSnJ8D2SBZzKA+"
                          @"Irm7mH1TgAn4BXbhiC2cb0VuMzL3gkncafpnP8MMEvR7T+XnauRk5//"
                          @"t+oFUBhLfB9YlWFeXnsEMwV+c21xaPDU/HmncOBQywXy/ELUGsHaIo9f91gPG5u/"
                          @"xszr0jFO+MzgSM5QF1MATiq80bRwsf0S3jjFOBjGxMgGvm3WdXS+"
                          @"KXvDcEcoQMB8shFKRi+"
                          @"NyGTB8O6BDyg2q55wFA8ZmgrAJ8Cy38xQhNA1lcT1DtuIQHMs+"
                          @"EV4sgAvPlBAkSD0xYrnZOwasJwHgNGt5kC+YNRkJqMrZQWcTo/"
                          @"HvJRkWucBDNK7x+OSWmtfoM+D8bvKRusnZXF6gLdK1OKA9OoAhT+"
                          @"qpHTHQSV7Y5WHqBUO0kEEcfeNmI2WWeOkUdoTj4Dc7LT8BRlgy93uICDOQmkwAteYM"
                          @"WpfxhorAxMzkjF0zL3roJBKXiGxj9d7WJTTPcyGf7cF0gA8b24UmCJwAgz4q1TVKUV"
                          @"2CaicXEWZl6ZrnrCH0zpmJGZhkn9BiL0qkTWyU+0IuRC+93AdjOO/"
                          @"z0Ly26kYJiVhmmDU/"
                          @"Di1YNwtMIGfEHW9+sfE2H3Ctbx9eoXQGt+"
                          @"1jhbrwEiMoO6OkSVhMNLsvDuuKFYfHWGenO1Lwg8PdXLidcBQU2EWjcQtAFVZhx4xY"
                          @"CG57KBgBM4nsfEjXf8tcwDNmsE9fcA/"
                          @"G0WQUGeq3lGcAAhG8EKVJrp6FQtgzo5Uet3/Dt0xCE6HmPr/"
                          @"JxExw4yATbCJ+"
                          @"kVoPNVYDAasVUhyNrYQ8ddHk2kHujyRLrcitvDguAHKI1DgDKJkYn18KPXe4T6BSjJ"
                          @"+gt8Jv1l8JpWAlzWaAm6/SSAcC95QHwChC5/"
                          @"ATSsoSxgthO5XhUAEUIDoZFQTwhfonZ5yPOW1g4T9unyguIYMUBvJA+"
                          @"4gV2Ekx7gS8JRGThA2Es4TDjhAb4ifC7zsjnQE11itRRepAkgLiMB9AfBgCsRAXgO3"
                          @"yMD5zzATjfqXnfAN9WGt39mwWs/"
                          @"NmPJDWa8cYsFK35lwcYn7Dhc7AK+"
                          @"8ACnCOFuFiLA7sH20IWO0I0J1gH6re53cyJk4Uoit8hjwiP9RExKEvBwPwHTk0XMSB"
                          @"ExbYCIKXSOnZ+VIeLVmyxoWuEEznqA/TKJ2H0NUtTbr/"
                          @"9GV1j4LL5SWNZNHgRGoHmDG8/"
                          @"mmfAgkZuZJuJJUcJTJglPSm3Bzz+"
                          @"RLWFykkCCiPhoopVPleZuEiHspg1WuclRAcrEebqmQZEARBdDsRFwqy6/"
                          @"9yMXZiZz6z5ljhKPhQV07eOjJPyWhFj6IzPwTw9whETwd/"
                          @"EhSZ2jpM02VtMw3f2ArbwfoGvOn/bgswoXpg8QVTd/"
                          @"2sqIxQcuFhfhvZ9a+"
                          @"FTa2bXqkrxyYgf7AUzPwyd1xyMx7vqHZLTslrHQbkJBkkDko4TmixLmZkqYniZhSn8"
                          @"JBQwDNGjfZwwi62ex6znmCxIeSDKi5lkHm1JdCYoKBfIh7QUoHjkIJdLZ2E1Rk9YKv"
                          @"6jCwBkP1kyxYSLd9AILJ/HHkZzc1BRyb5uEpT+UUDhBQuUUCdseFRnUzx/"
                          @"eLeFvY+j6K0mgJAlzRkiqgNNTRCx0mXC+"
                          @"zs3SZqLWX97588G1w2fDZ774kriEtcWjPYGOwKL9yc1uzKP5OzNdVAlPJiLzsiW8db"
                          @"uE8CIRpz8UgA1GoIqwg1CtYYd2rtKI5ndFlD7A48CkJC7gVPKmyMsONhUSEyAk58bY"
                          @"FWY9CK+OfQGdPxhVCxn/"
                          @"c3b8OklUXf3VsSK2TBdw4m2NXFCkMUzAZgvrMfI226cEOqrfN1lJHDNQJQIBI06uNK"
                          @"LoPhGzhkj4CQlQNtXGgmsi0X+"
                          @"djo1Rmd9CMVsgSZ33BdeaL74zZK8HpwvNCD2WjeYlgtotwk4TELTyLFKrFVMNns5Rx"
                          @"6M9tmmbKesFHFlixIvXGFC90Moqxji3y+"
                          @"QCO6426dsosVGYiTIzOvWEIl4PdBoMgzJvZTdZiDgdgy6+hm/8Bjk9/"
                          @"fu66DsFINHQYAWqJXVsJaJTAPpt7dHd3Di3wBvewSpL59lgvZkT6rR7o4uwftRxj0E"
                          @"jXyPoToORXCib5A2J7RYrt61Vp4K3YxGUHc5Lv0MsHF/NT/"
                          @"d3APtTU7qwQdq4Hj5Tx7HAJ7G53Hc3Svhzm5WIM7vrO0bXSqvglTrOCJUWpnIfa4Op"
                          @"Btmv+HMM3blbfDlKOxFhmw1KUx8SIegKUbWX2QNb5oUCvmlaar1MXq0+MuMiRGL0/"
                          @"3s4PiAsL+3hV2WyZXjFchKivQhbbNHIf0nJq6I3Ub6/"
                          @"8xK+MGWeQJ7AX43zSbxMLtSKpKA7+r5QT+"
                          @"764jhKy9vZSsjZr5denhLuI3yiTosSrUYoEfhj9HAPCBGWOSKueiXsnIlATkbfeHfQ"
                          @"J4xFhfgSCbHvv6/"
                          @"N+UQuhN+lvT6XQFEUlHk+"
                          @"53O8mQLcm6i13ta33x5dbRiLMtMTKBZKSYjDqmdUWnigjK4DuCARrVwNccu2mdvHKY"
                          @"9XKg32Z5SQ6ybU2HhBczmBPKI/"
                          @"wYXCrHFYaZiCUvEZlJuWYYPlfWy1lZJ3VJAgFSTCB0rA+"
                          @"QoRn0tCjKfv31b8nkE9SOD/f/8B4yD6Jw4yc3oAAAAASUVORK5CYII=\" "
                          @"style=\"width: 20%%; height: auto;\">"
                          @"</body>"
                          @"</html>"];

  [_webView loadHTMLString:htmlString baseURL:nil];
}

#pragma mark - Web View

- (void)userContentController:(WKUserContentController*)userContentController
      didReceiveScriptMessage:(WKScriptMessage*)message {
  if ([message.name isEqualToString:kContentLoadedMessage]) {
    NSLog(@"Image was loaded");
  }
}

@end
