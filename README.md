# OSKOgpParser
Parsing Ogp tags from url.

#Usage🐰
1.import

`#import "OSKOgpParser.h"`

2.call `getOgpElement` method.

```Objc
[OSKOgpParser getOgpElement:[NSURL URLWithString:@"http://blog.esuteru.com/archives/8180815.html"]
                        success:^(OSKOgpObject *object) {
                            NSLog(@"success");
                            NSLog(@"%@",object.debugDescription);
                        } failure:^(NSError *error) {
                            NSLog(@"error");
                            NSLog(@"%@",error.localizedDescription);
                        }];
```

3.happy

```
title:『ペルソナ4ダンシング・オールナイト』マーガレットが参戦決定！番長のスケバン＆完二のセクシー衣装DLCも配信決定ｗｗｗｗｗ : はちま起稿
type:article
description:
url:http://blog.esuteru.com/archives/8180815.html
image:http://livedoor.blogimg.jp/hatima/imgs/c/c/ccfb124e.png
site_name:はちま起稿
email:(null)
```

##LICENSE
The MIT License (MIT)
Copyright (c) 2015 @noppefoxwolf

