
//
//  Header.h
//  LimitFree
//
//  Created by DuHaiFeng on 13-12-24.
//  Copyright (c) 2013年 dhf. All rights reserved.
//

#ifndef LimitFree_Header_h
#define LimitFree_Header_h

//限免接口  ***************************
#define LIMIT_TYPE 1
#define LIMIT_URL(page,number) [NSString stringWithFormat:@"http://iappfree.candou.com:8080/free/applications/limited?page=%d&number=%d",page,number]
//限免分类
#define LIMIT_BY_CATEGORYID_URL(page,number,categoryid) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/limited.php?page=%d&number=%d&cate_id=%d",page,number,categoryid]
//限免搜索
#define LIMIT_SEARCH_URL(page,number,searchtext) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/limited.php?page=%d&number=%d&search=%@",page,number,searchtext]


//降价接口  ***************************
#define REDUCE_TYPE 2
#define REDUCE_URL(page,number) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/reduce.php?page=%d&number=%d",page,number]
//降价分类
#define REDUCE_BY_CATEGORYID_URL(page,number,categoryid) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/reduce.php?page=%d&number=%d&cate_id=%d",page,number,categoryid]
//降价搜索
#define REDUCE_SEARCH_URL(page,number,searchtext) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/reduce.php?page=%d&number=%d&search=%@",page,number,searchtext]


//免费接口  ***************************
#define FREE_TYPE 3
#define FREE_URL(page,number) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/free.php?page=%d&number=%d",page,number]
//免费分类
#define FREE_BY_CATEGORYID_URL(page,number,categoryid) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/free.php?page=%d&number=%d&cate_id=%d",page,number,categoryid]
//免费搜索
#define FREE_SEARCH_URL(page,number,searchtext) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/free.php?page=%d&number=%d&search=%@",page,number,searchtext]


//专题接口  ***************************
#define SUBJECT_TYPE 4
//#define SUBJECT_URL @"http://1000phone.net:8088/app/iAppFree/api/special.php?page=%d&number=%d"
//#define SUBJECT_URL @"http://iappfree.candou.com:8080/free/special?page=%d&limit=%d"
#define SUBJECT_URL(page,number) [NSString stringWithFormat:@"http://iappfree.candou.com:8080/free/special?page=%d&limit=%d",page,number]


//热榜接口  ***************************
#define HOT_TYPE 5
//#define HOT_URL @"http://1000phone.net:8088/app/iAppFree/api/hot.php?page=%d&number=%d"
#define HOT_URL(page,number) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/hot.php?page=%d&number=%d",page,number]
//热榜分类
#define HOT_BY_CATEGORYID_URL(page,number,categoryid) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/hot.php?page=%d&number=%d&cate_id=%d",page,number,categoryid]
//热榜搜索
#define HOT_SEARCH_URL(page,number,searchtext) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/hot.php?page=%d&number=%d&search=%@",page,number,searchtext]



//详情接口  ***************************
#define DETAIL_URL(appId) [NSString stringWithFormat:@"http://iappfree.candou.com:8080/free/applications/%@",appId]
#define DETAIL_URL_RMB(appId) [NSString stringWithFormat: @"http://iappfree.candou.com:8080/free/applications/%@?currency=rmb",appId]

//分类API  ***************************
#define APPCATE @"http://1000phone.net:8088/app/iAppFree/api/appcate.php"

//附近的人  ***************************
#define RECOMMENT_URL @"http://iappfree.candou.com:8080/free/applications/recommend?longitude=116.344539&latitude=40.034346"

//#define CATEGORY_URL @"http://1000phone.net:8080/app/iAppFree/api/appcate.php"
#define CATEGORY_URL @"http://open.candou.com/app/count"
#endif














//专题接口地址
//#define SUBJECT_URL @"http://iappfree.candou.com:8080/free/special"

////搜索接口
//#define Limit_SEARCH @"http://1000phone.net:8088/app/iAppFree/api/limited.php?page=1&number=20&search=愤怒的小鸟"
//
////#define SALE_SEARCH @"http://1000phone.net:8088/app/iAppFree/api/reduce.php?page=1&number=10&search="
//#define REDUCE_SEARCH_URL(page,number,searchtext) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/reduce.php?page=%d&number=%d&search=%@",page,number,searchtext]
//
////#define FREE_SEARCH @"http://1000phone.net:8088/app/iAppFree/api/free.php?page=1&number=20&search=愤怒的小鸟"
//#define FREE_SEARCH_URL(page,number,searchtext) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/free.php?page=%d&number=%d&search=%@",page,number,searchtext]
//
//#define HOT_SEARCH @"http://1000phone.net:8088/app/iAppFree/api/hot.php?page=1&number=20&search=愤怒的小鸟"


////分类API
//#define APPCATE @"http://1000phone.net:8088/app/iAppFree/api/appcate.php"
//
////分类限免费接口:
//#define APPCATE_LIMIT @"http://1000phone.net:8088/app/iAppFree/api/limited.php?page=1&number=20&cate_id=6014"
////分类降价接口:
//#define APPCATE_SALE @"http://1000phone.net:8088/app/iAppFree/api/reduce.php?page=1&number=10&cate_id=6014"
////分类免费接口:
//#define APPCATE_FREE @"http://1000phone.net:8088/app/iAppFree/api/free.php?page=1&number=20&cate_id=6014"
////分类热榜接口:
//#define APPCATE_HOT @"http://1000phone.net:8088/app/iAppFree/api/hot.php?page=1&number=20&cate_id=6014"
////参数page，表示显示第几页结果。
////cate_id表示分组id








