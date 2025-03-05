#import "CityManager.h"
#import <Foundation/Foundation.h>

@implementation CityManager

+ (instancetype)sharedInstance {
    static CityManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CityManager alloc] init];
        [instance loadCityData];
    });
    return instance;
}

- (void)loadCityData {
    self.cityCodeMap = @{
        @"4":@"阿富汗",
        @"8":@"阿尔巴尼亚",
        @"12":@"阿尔及利亚",
        @"20":@"安道尔",
        @"24":@"安哥拉",
        @"28":@"安提瓜和巴布达",
        @"31":@"阿塞拜疆",
        @"32":@"阿根廷",
        @"36":@"澳大利亚",
        @"40":@"奥地利",
        @"44":@"巴哈马",
        @"48":@"巴林",
        @"50":@"孟加拉国",
        @"51":@"亚美尼亚",
        @"52":@"巴巴多斯",
        @"56":@"比利时",
        @"64":@"不丹",
        @"68":@"玻利维亚",
        @"70":@"波黑",
        @"72":@"博茨瓦纳",
        @"76":@"巴西",
        @"84":@"伯利兹",
        @"90":@"所罗门群岛",
        @"92":@"英属维尔京群岛",
        @"96":@"文莱",
        @"100":@"保加利亚",
        @"104":@"缅甸",
        @"108":@"布隆迪",
        @"112":@"白俄罗斯",
        @"116":@"柬埔寨",
        @"120":@"喀麦隆",
        @"124":@"加拿大",
        @"132":@"佛得角",
        @"136":@"开曼群岛",
        @"144":@"斯里兰卡",
        @"148":@"乍得",
        @"152":@"智利",
        @"170":@"哥伦比亚",
        @"174":@"科摩罗",
        @"188":@"哥斯达黎加",
        @"191":@"克罗地亚",
        @"196":@"塞浦路斯",
        @"203":@"捷克",
        @"204":@"贝宁",
        @"208":@"丹麦",
        @"212":@"多米尼克",
        @"214":@"多米尼加",
        @"218":@"厄瓜多尔",
        @"222":@"萨尔瓦多",
        @"226":@"赤道几内亚",
        @"231":@"埃塞俄比亚",
        @"232":@"厄立特里亚",
        @"233":@"爱沙尼亚",
        @"242":@"斐济",
        @"246":@"芬兰",
        @"250":@"法国",
        @"262":@"吉布提",
        @"266":@"加蓬",
        @"268":@"格鲁吉亚",
        @"270":@"冈比亚",
        @"275":@"巴勒斯坦*",
        @"276":@"德国",
        @"288":@"加纳",
        @"292":@"直布罗陀",
        @"296":@"基里巴斯",
        @"300":@"希腊",
        @"308":@"格林纳达",
        @"320":@"危地马拉",
        @"324":@"几内亚",
        @"328":@"圭亚那",
        @"332":@"海地",
        @"336":@"梵蒂冈",
        @"340":@"洪都拉斯",
        @"348":@"匈牙利",
        @"352":@"冰岛",
        @"356":@"印度",
        @"360":@"印度尼西亚",
        @"368":@"伊拉克",
        @"372":@"爱尔兰",
        @"376":@"以色列",
        @"380":@"意大利",
        @"384":@"科特迪瓦",
        @"388":@"牙买加",
        @"392":@"日本",
        @"398":@"哈萨克斯坦",
        @"400":@"约旦",
        @"404":@"肯尼亚",
        @"410":@"韩国",
        @"414":@"科威特",
        @"417":@"吉尔吉斯斯坦",
        @"418":@"老挝",
        @"422":@"黎巴嫩",
        @"426":@"莱索托",
        @"428":@"拉脱维亚",
        @"430":@"利比里亚",
        @"434":@"利比亚",
        @"438":@"列支敦士登",
        @"440":@"立陶宛",
        @"442":@"卢森堡",
        @"450":@"马达加斯加",
        @"454":@"马拉维",
        @"458":@"马来西亚",
        @"462":@"马尔代夫",
        @"466":@"马里",
        @"470":@"马耳他",
        @"478":@"毛里塔尼亚",
        @"480":@"毛里求斯",
        @"484":@"墨西哥",
        @"492":@"摩纳哥",
        @"496":@"蒙古国",
        @"498":@"摩尔多瓦",
        @"499":@"黑山",
        @"504":@"摩洛哥",
        @"508":@"莫桑比克",
        @"512":@"阿曼",
        @"516":@"纳米比亚",
        @"520":@"瑙鲁",
        @"524":@"尼泊尔",
        @"528":@"荷兰",
        @"548":@"瓦努阿图",
        @"554":@"新西兰",
        @"558":@"尼加拉瓜",
        @"562":@"尼日尔",
        @"566":@"尼日利亚",
        @"583":@"密克罗尼西亚联邦",
        @"584":@"马绍尔群岛",
        @"585":@"帕劳",
        @"586":@"巴基斯坦",
        @"591":@"巴拿马",
        @"598":@"巴布亚新几内亚",
        @"600":@"巴拉圭",
        @"604":@"秘鲁",
        @"608":@"菲律宾",
        @"616":@"波兰",
        @"620":@"葡萄牙",
        @"624":@"几内亚比绍",
        @"626":@"东帝汶",
        @"630":@"波多黎各",
        @"634":@"卡塔尔",
        @"642":@"罗马尼亚",
        @"643":@"俄罗斯",
        @"646":@"卢旺达",
        @"659":@"圣基茨和尼维斯",
        @"662":@"圣卢西亚",
        @"670":@"圣文森特和格林纳丁斯",
        @"674":@"圣马力诺",
        @"678":@"圣多美和普林西比",
        @"682":@"沙特阿拉伯",
        @"686":@"塞内加尔",
        @"688":@"塞尔维亚",
        @"690":@"塞舌尔",
        @"694":@"塞拉利昂",
        @"702":@"新加坡",
        @"703":@"斯洛伐克",
        @"704":@"越南",
        @"705":@"斯洛文尼亚",
        @"706":@"索马里",
        @"710":@"南非",
        @"716":@"津巴布韦",
        @"724":@"西班牙",
        @"740":@"苏里南",
        @"744":@"挪威",
        @"748":@"斯威士兰",
        @"752":@"瑞典",
        @"756":@"瑞士",
        @"762":@"塔吉克斯坦",
        @"764":@"泰国",
        @"768":@"多哥",
        @"776":@"汤加",
        @"780":@"特立尼达和多巴哥",
        @"784":@"阿联酋",
        @"788":@"突尼斯",
        @"792":@"土耳其",
        @"795":@"土库曼斯坦",
        @"798":@"图瓦卢",
        @"800":@"乌干达",
        @"804":@"乌克兰",
        @"807":@"马其顿",
        @"818":@"埃及",
        @"826":@"英国",
        @"834":@"坦桑尼亚",
        @"840":@"美国",
        @"854":@"布基纳法索",
        @"858":@"乌拉圭",
        @"860":@"乌兹别克斯坦",
        @"862":@"委内瑞拉",
        @"882":@"萨摩亚",
        @"887":@"也门",
        @"894":@"赞比亚",
        @"110000":@"北京",
        @"110100":@"北京",
        @"120000":@"天津",
        @"120100":@"天津",
        @"130000":@"河北",
        @"130100":@"石家庄",
        @"130200":@"唐山",
        @"130300":@"秦皇岛",
        @"130400":@"邯郸",
        @"130500":@"邢台",
        @"130600":@"保定",
        @"130700":@"张家口",
        @"130800":@"承德",
        @"130900":@"沧州",
        @"131000":@"廊坊",
        @"131100":@"衡水",
        @"140000":@"山西",
        @"140100":@"太原",
        @"140200":@"大同",
        @"140300":@"阳泉",
        @"140400":@"长治",
        @"140500":@"晋城",
        @"140600":@"朔州",
        @"140700":@"晋中",
        @"140800":@"运城",
        @"140900":@"忻州",
        @"141000":@"临汾",
        @"141100":@"吕梁",
        @"150000":@"内蒙古",
        @"150100":@"呼和浩特",
        @"150200":@"包头",
        @"150300":@"乌海",
        @"150400":@"赤峰",
        @"150500":@"通辽",
        @"150600":@"鄂尔多斯",
        @"150700":@"呼伦贝尔",
        @"150800":@"巴彦淖尔",
        @"150900":@"乌兰察布",
        @"152200":@"兴安",
        @"152500":@"锡林郭勒",
        @"152900":@"阿拉善",
        @"210000":@"辽宁",
        @"210100":@"沈阳",
        @"210200":@"大连",
        @"210300":@"鞍山",
        @"210400":@"抚顺",
        @"210500":@"本溪",
        @"210600":@"丹东",
        @"210700":@"锦州",
        @"210800":@"营口",
        @"210900":@"阜新",
        @"211000":@"辽阳",
        @"211100":@"盘锦",
        @"211200":@"铁岭",
        @"211300":@"朝阳",
        @"211400":@"葫芦岛",
        @"220000":@"吉林",
        @"220100":@"长春",
        @"220200":@"吉林",
        @"220300":@"四平",
        @"220400":@"辽源",
        @"220500":@"通化",
        @"220600":@"白山",
        @"220700":@"松原",
        @"220800":@"白城",
        @"222400":@"延边",
        @"230000":@"黑龙江",
        @"230100":@"哈尔滨",
        @"230200":@"齐齐哈尔",
        @"230300":@"鸡西",
        @"230400":@"鹤岗",
        @"230500":@"双鸭山",
        @"230600":@"大庆",
        @"230700":@"伊春",
        @"230800":@"佳木斯",
        @"230900":@"七台河",
        @"231000":@"牡丹江",
        @"231100":@"黑河",
        @"231200":@"绥化",
        @"232700":@"大兴安岭",
        @"310000":@"上海",
        @"310100":@"上海",
        @"320000":@"江苏",
        @"320100":@"南京",
        @"320200":@"无锡",
        @"320300":@"徐州",
        @"320400":@"常州",
        @"320500":@"苏州",
        @"320600":@"南通",
        @"320700":@"连云港",
        @"320800":@"淮安",
        @"320900":@"盐城",
        @"321000":@"扬州",
        @"321100":@"镇江",
        @"321200":@"泰州",
        @"321300":@"宿迁",
        @"330000":@"浙江",
        @"330100":@"杭州",
        @"330200":@"宁波",
        @"330300":@"温州",
        @"330400":@"嘉兴",
        @"330500":@"湖州",
        @"330600":@"绍兴",
        @"330700":@"金华",
        @"330800":@"衢州",
        @"330900":@"舟山",
        @"331000":@"台州",
        @"331100":@"丽水",
        @"340000":@"安徽",
        @"340100":@"合肥",
        @"340200":@"芜湖",
        @"340300":@"蚌埠",
        @"340400":@"淮南",
        @"340500":@"马鞍山",
        @"340600":@"淮北",
        @"340700":@"铜陵",
        @"340800":@"安庆",
        @"341000":@"黄山",
        @"341100":@"滁州",
        @"341200":@"阜阳",
        @"341300":@"宿州",
        @"341500":@"六安",
        @"341600":@"亳州",
        @"341700":@"池州",
        @"341800":@"宣城",
        @"350000":@"福建",
        @"350100":@"福州",
        @"350200":@"厦门",
        @"350300":@"莆田",
        @"350400":@"三明",
        @"350500":@"泉州",
        @"350600":@"漳州",
        @"350700":@"南平",
        @"350800":@"龙岩",
        @"350900":@"宁德",
        @"360000":@"江西",
        @"360100":@"南昌",
        @"360200":@"景德镇",
        @"360300":@"萍乡",
        @"360400":@"九江",
        @"360500":@"新余",
        @"360600":@"鹰潭",
        @"360700":@"赣州",
        @"360800":@"吉安",
        @"360900":@"宜春",
        @"361000":@"抚州",
        @"361100":@"上饶",
        @"370000":@"山东",
        @"370100":@"济南",
        @"370200":@"青岛",
        @"370300":@"淄博",
        @"370400":@"枣庄",
        @"370500":@"东营",
        @"370600":@"烟台",
        @"370700":@"潍坊",
        @"370800":@"济宁",
        @"370900":@"泰安",
        @"371000":@"威海",
        @"371100":@"日照",
        @"371200":@"莱芜",
        @"371300":@"临沂",
        @"371400":@"德州",
        @"371500":@"聊城",
        @"371600":@"滨州",
        @"371700":@"菏泽",
        @"410000":@"河南",
        @"410100":@"郑州",
        @"410200":@"开封",
        @"410300":@"洛阳",
        @"410400":@"平顶山",
        @"410500":@"安阳",
        @"410600":@"鹤壁",
        @"410700":@"新乡",
        @"410800":@"焦作",
        @"410900":@"濮阳",
        @"411000":@"许昌",
        @"411100":@"漯河",
        @"411200":@"三门峡",
        @"411300":@"南阳",
        @"411400":@"商丘",
        @"411500":@"信阳",
        @"411600":@"周口",
        @"411700":@"驻马店",
        @"419001":@"济源",
        @"420000":@"湖北",
        @"420100":@"武汉",
        @"420200":@"黄石",
        @"420300":@"十堰",
        @"420500":@"宜昌",
        @"420600":@"襄阳",
        @"420700":@"鄂州",
        @"420800":@"荆门",
        @"420900":@"孝感",
        @"421000":@"荆州",
        @"421100":@"黄冈",
        @"421200":@"咸宁",
        @"421300":@"随州",
        @"422800":@"恩施",
        @"429004":@"仙桃",
        @"429005":@"潜江",
        @"429006":@"天门",
        @"429021":@"神农架",
        @"430000":@"湖南",
        @"430100":@"长沙",
        @"430200":@"株洲",
        @"430300":@"湘潭",
        @"430400":@"衡阳",
        @"430500":@"邵阳",
        @"430600":@"岳阳",
        @"430700":@"常德",
        @"430800":@"张家界",
        @"430900":@"益阳",
        @"431000":@"郴州",
        @"431100":@"永州",
        @"431200":@"怀化",
        @"431300":@"娄底",
        @"433100":@"湘西",
        @"440000":@"广东",
        @"440100":@"广州",
        @"440200":@"韶关",
        @"440300":@"深圳",
        @"440400":@"珠海",
        @"440500":@"汕头",
        @"440600":@"佛山",
        @"440700":@"江门",
        @"440800":@"湛江",
        @"440900":@"茂名",
        @"441200":@"肇庆",
        @"441300":@"惠州",
        @"441400":@"梅州",
        @"441500":@"汕尾",
        @"441600":@"河源",
        @"441700":@"阳江",
        @"441800":@"清远",
        @"441900":@"东莞",
        @"442000":@"中山",
        @"445100":@"潮州",
        @"445200":@"揭阳",
        @"445300":@"云浮",
        @"450000":@"广西",
        @"450100":@"南宁",
        @"450200":@"柳州",
        @"450300":@"桂林",
        @"450400":@"梧州",
        @"450500":@"北海",
        @"450600":@"防城港",
        @"450700":@"钦州",
        @"450800":@"贵港",
        @"450900":@"玉林",
        @"451000":@"百色",
        @"451100":@"贺州",
        @"451200":@"河池",
        @"451300":@"来宾",
        @"451400":@"崇左",
        @"460000":@"海南",
        @"460100":@"海口",
        @"460200":@"三亚",
        @"460300":@"三沙",
        @"460400":@"儋州",
        @"469001":@"五指山",
        @"469002":@"琼海",
        @"469005":@"文昌",
        @"469006":@"万宁",
        @"469007":@"东方",
        @"469021":@"定安",
        @"469022":@"屯昌",
        @"469023":@"澄迈",
        @"469024":@"临高",
        @"469025":@"白沙",
        @"469026":@"昌江",
        @"469027":@"乐东",
        @"469028":@"陵水",
        @"469029":@"保亭",
        @"469030":@"琼中",
        @"500000":@"重庆",
        @"500100":@"重庆",
        @"510000":@"四川",
        @"510100":@"成都",
        @"510300":@"自贡",
        @"510400":@"攀枝花",
        @"510500":@"泸州",
        @"510600":@"德阳",
        @"510700":@"绵阳",
        @"510800":@"广元",
        @"510900":@"遂宁",
        @"511000":@"内江",
        @"511100":@"乐山",
        @"511300":@"南充",
        @"511400":@"眉山",
        @"511500":@"宜宾",
        @"511600":@"广安",
        @"511700":@"达州",
        @"511800":@"雅安",
        @"511900":@"巴中",
        @"512000":@"资阳",
        @"513200":@"阿坝",
        @"513300":@"甘孜",
        @"513400":@"凉山",
        @"520000":@"贵州",
        @"520100":@"贵阳",
        @"520200":@"六盘水",
        @"520300":@"遵义",
        @"520400":@"安顺",
        @"520500":@"毕节",
        @"520600":@"铜仁",
        @"522300":@"黔西南",
        @"522600":@"黔东南",
        @"522700":@"黔南",
        @"530000":@"云南",
        @"530100":@"昆明",
        @"530300":@"曲靖",
        @"530400":@"玉溪",
        @"530500":@"保山",
        @"530600":@"昭通",
        @"530700":@"丽江",
        @"530800":@"普洱",
        @"530900":@"临沧",
        @"532300":@"楚雄",
        @"532500":@"红河",
        @"532600":@"文山",
        @"532800":@"西双版纳",
        @"532900":@"大理",
        @"533100":@"德宏",
        @"533300":@"怒江",
        @"533400":@"迪庆",
        @"540000":@"西藏",
        @"540100":@"拉萨",
        @"540200":@"日喀则",
        @"540300":@"昌都",
        @"540400":@"林芝",
        @"540500":@"山南",
        @"542400":@"那曲",
        @"542500":@"阿里",
        @"610000":@"陕西",
        @"610100":@"西安",
        @"610200":@"铜川",
        @"610300":@"宝鸡",
        @"610400":@"咸阳",
        @"610500":@"渭南",
        @"610600":@"延安",
        @"610700":@"汉中",
        @"610800":@"榆林",
        @"610900":@"安康",
        @"611000":@"商洛",
        @"620000":@"甘肃",
        @"620100":@"兰州",
        @"620200":@"嘉峪关",
        @"620300":@"金昌",
        @"620400":@"白银",
        @"620500":@"天水",
        @"620600":@"武威",
        @"620700":@"张掖",
        @"620800":@"平凉",
        @"620900":@"酒泉",
        @"621000":@"庆阳",
        @"621100":@"定西",
        @"621200":@"陇南",
        @"622900":@"临夏",
        @"623000":@"甘南",
        @"630000":@"青海",
        @"630100":@"西宁",
        @"630200":@"海东",
        @"632200":@"海北",
        @"632300":@"黄南",
        @"632500":@"海南",
        @"632600":@"果洛",
        @"632700":@"玉树",
        @"632800":@"海西",
        @"640000":@"宁夏",
        @"640100":@"银川",
        @"640200":@"石嘴山",
        @"640300":@"吴忠",
        @"640400":@"固原",
        @"640500":@"中卫",
        @"650000":@"新疆",
        @"650100":@"乌鲁木齐",
        @"650200":@"克拉玛依",
        @"650400":@"吐鲁番",
        @"650500":@"哈密",
        @"652300":@"昌吉",
        @"652700":@"博尔塔拉",
        @"652800":@"巴音郭楞",
        @"652900":@"阿克苏",
        @"653000":@"克孜勒苏",
        @"653100":@"喀什",
        @"653200":@"和田",
        @"654000":@"伊犁",
        @"654200":@"塔城",
        @"654300":@"阿勒泰",
        @"659001":@"石河子",
        @"659002":@"阿拉尔",
        @"659003":@"图木舒克",
        @"659004":@"五家渠",
        @"659005":@"北屯",
        @"659006":@"铁门关",
        @"659007":@"双河",
        @"659008":@"可克达拉",
        @"710000":@"台湾",
        @"710100":@"台湾",
        @"810000":@"香港",
        @"810100":@"香港",
        @"820100":@"澳门"
    };
}

- (NSString *)getCityNameWithCode:(NSString *)code {
    if (!code || code.length < 6) {
        return nil;
    }
    
    NSString *cityName = self.cityCodeMap[code];
    
    if (!cityName) {
    return cityName;
    }
}

- (NSString *)getprovinceNameWithCode:(NSString *)code {
    if (!code || code.length < 6) {
        return nil;
    }
    NSString *provinceCode = [code substringToIndex:2];
    provinceCode = [provinceCode stringByAppendingString:@"0000"];
    NSString *provinceCodeName = self.cityCodeMap[provinceCode];
    
    if (!provinceCodeName) {
        return provinceCodeName;
    }
}
@end
