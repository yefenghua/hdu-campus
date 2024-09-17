/*
 Navicat Premium Data Transfer

 Source Server         : local mysql
 Source Server Type    : MySQL
 Source Server Version : 80036 (8.0.36)
 Source Host           : localhost:3306
 Source Schema         : study

 Target Server Type    : MySQL
 Target Server Version : 80036 (8.0.36)
 File Encoding         : 65001

 Date: 17/09/2024 22:51:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for db_account
-- ----------------------------
DROP TABLE IF EXISTS `db_account`;
CREATE TABLE `db_account`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `register_time` datetime NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_name`(`username` ASC) USING BTREE,
  UNIQUE INDEX `unique_email`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of db_account
-- ----------------------------
INSERT INTO `db_account` VALUES (1, '叶丰华', '$2a$10$tWN0PHLACioCScm5nIjDGuxDbEd73IIkWi0X2wL2BUG/zwitXTs9y', 'yfh1347182719@outlook.com', 'user', '2024-08-11 20:42:24', '/avatar/e89bf5a03a08482c880b30edcca4b77e');

-- ----------------------------
-- Table structure for db_account_details
-- ----------------------------
DROP TABLE IF EXISTS `db_account_details`;
CREATE TABLE `db_account_details`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `gender` tinyint NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `qq` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `wx` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of db_account_details
-- ----------------------------
INSERT INTO `db_account_details` VALUES (1, 0, '18268640252', '3127149213', '18268640252', '你好，我是杭州电子科技大学数字媒体技术专业的大三学生叶丰华，我非常喜欢敲代码，非常高兴可以认识你们~');

-- ----------------------------
-- Table structure for db_account_privacy
-- ----------------------------
DROP TABLE IF EXISTS `db_account_privacy`;
CREATE TABLE `db_account_privacy`  (
  `id` int NOT NULL,
  `phone` tinyint NULL DEFAULT NULL,
  `wx` tinyint NULL DEFAULT NULL,
  `qq` tinyint NULL DEFAULT NULL,
  `gender` tinyint NULL DEFAULT NULL,
  `email` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of db_account_privacy
-- ----------------------------
INSERT INTO `db_account_privacy` VALUES (1, 1, 0, 0, 1, 1);

-- ----------------------------
-- Table structure for db_image_store
-- ----------------------------
DROP TABLE IF EXISTS `db_image_store`;
CREATE TABLE `db_image_store`  (
  `uid` int NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of db_image_store
-- ----------------------------
INSERT INTO `db_image_store` VALUES (1, '/cache/20240908/30045f0c9a5c4f6a9c81827f803c3262', '2024-09-08 20:02:45');
INSERT INTO `db_image_store` VALUES (1, '/cache/20240908/a833695bbb194b35a3f26f7d4036a20d', '2024-09-08 20:11:36');
INSERT INTO `db_image_store` VALUES (1, '/cache/20240909/d77facf6c9e742acb945f9d45b980a60', '2024-09-09 09:45:11');
INSERT INTO `db_image_store` VALUES (1, '/cache/20240909/02f8fcc323c545fb8880db04222bd9bd', '2024-09-09 09:46:26');
INSERT INTO `db_image_store` VALUES (1, '/cache/20240909/42b358cdb6834821a182f9ecc754071f', '2024-09-09 09:47:22');
INSERT INTO `db_image_store` VALUES (1, '/cache/20240909/8bcf378b5f594b7cab01c339d97b214c', '2024-09-09 10:13:08');
INSERT INTO `db_image_store` VALUES (1, '/cache/20240909/1f05eb31e71e4d8297e43935d20f59e3', '2024-09-09 10:14:20');
INSERT INTO `db_image_store` VALUES (1, '/cache/20240909/0d7d4a3ccc9446819b5fde74eaf94f0a', '2024-09-09 10:17:09');
INSERT INTO `db_image_store` VALUES (1, '/cache/20240917/500fb87853e84025ae6da371b1d522ab', '2024-09-17 16:48:07');
INSERT INTO `db_image_store` VALUES (1, '/cache/20240917/10450a33de324daba11ae339cf53d4b6', '2024-09-17 16:48:24');
INSERT INTO `db_image_store` VALUES (1, '/cache/20240917/f6a6343053a848bd8a81cba37dc72b37', '2024-09-17 16:48:29');
INSERT INTO `db_image_store` VALUES (1, '/cache/20240917/1517e2dc247742ff8892cca21638c2a3', '2024-09-17 16:49:03');
INSERT INTO `db_image_store` VALUES (1, '/cache/20240917/e2012e3e031b4c27b8ac0bf5e81c25f0', '2024-09-17 16:49:09');

-- ----------------------------
-- Table structure for db_topic
-- ----------------------------
DROP TABLE IF EXISTS `db_topic`;
CREATE TABLE `db_topic`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `uid` int NULL DEFAULT NULL,
  `type` int NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  `top` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of db_topic
-- ----------------------------
INSERT INTO `db_topic` VALUES (1, '121212121', '{\"ops\":[{\"insert\":\"11111121\\n\"},{\"insert\":{\"image\":\"http://localhost:8080/images/cache/20240909/1f05eb31e71e4d8297e43935d20f59e3\"}},{\"insert\":\"\\n22222222\\n\"}]}', 1, 1, '2024-09-09 10:14:52', 0);
INSERT INTO `db_topic` VALUES (2, '和cyt的第不知道多少天', '{\"ops\":[{\"insert\":\"啦啦啦啦啦啦啦啦啦\\n\"},{\"insert\":{\"image\":\"http://localhost:8080/images/cache/20240909/0d7d4a3ccc9446819b5fde74eaf94f0a\"}},{\"insert\":\"\\n\"}]}', 1, 4, '2024-09-09 10:17:11', 1);
INSERT INTO `db_topic` VALUES (3, '端午节', '{\"ops\":[{\"insert\":\"结合往年中秋假期和今年五一、端午假期的流量情况，杭州公安高速交警预判，中秋假期期间流量高峰将集中在9月14日16时至21时、9月15日9时至12时出城时段；9月17日15时至22时返城时段。\\n其中出城时段，辖区杭州西、新萧山、萧山城区、紫金港、杭州南等5个主要出城口，将出现大流量车辆排队出城缓行情况。缓行路段集中在以G92杭甬高速萧山收费站－红垦枢纽－萧山城区，G60杭金衢高速红垦枢纽－张家畈枢纽段，G2504绕城高速下沙大桥路段，G25杭千高速杭州南收费站至袁富枢纽段、中埠至场口段、安仁至新安江枢纽段，G56杭徽高速杭州西（留下枢纽）至汪家埠枢纽段，S14杭长（宜）高速百丈、鱼石岭隧道等路段。\\n9月17日回程时段，要重点关注G25杭千高速新安江枢纽段、八亩丘至建金枢纽段、杭州南枢纽，G56杭徽高速於潜枢纽、汪家埠枢纽、岳山隧道群，S14杭长（宜）高速径山枢纽和径山服务区等路段。\\n杭州公安高速交警辖区的富阳、桐庐、建德、千岛湖、临安、余杭等地成为杭州和周边省市朋友出城郊游的首要选择。\\n富阳、桐庐、建德等路段受短途出行影响，杭新景高速杭州南枢纽和场口互通段容易存在排队缓行现象。建议如下绕行：\\n1.杭州绕城高速西线车辆，从转塘收费站下高速行驶至科海路，沿地方道路，至桐庐收费站重新上高速。\\n2.之江大桥方向车辆，行驶至科海路，沿地方道路至桐庐收费站重新上高速。\\n3.从杭州城区出发车辆，导航行驶至科海路，沿地方道路至桐庐收费站上高速。\\n4.场口互通至凤川互通路段出现缓行时，建议从场口收费站下高速走320国道，绕行至凤川收费站重新上高速。\\n5.杭州方向经绕城西线高速往南京、上海方向车辆，如遇绕城高速排队缓行可选择杭州南下高速，经紫之隧道绕行。\\n淳安千岛湖段前往千岛湖旅游的司乘人员，排队缓行点主要集中在新安江互通段。遇到青溪站排队缓行，可以选择千岛湖站下高速；选择淳开线附近景点，如文渊狮城、芹川古民居等地，选择汪宅收费站下高速，路程短且避开主城区缓行。\\n杭州临安段前往临安旅游的司乘人员，排队缓行点主要集中在G56杭徽高速岳山隧道群，临安、龙岗、於潜等路段是辖区主要景点点位，遇到前方缓行，可以提前下高速；司乘人员从市区出发的，建议沿天目山路至G329国道（原02省道）绕行；往临安、天目山方向的车辆，建议从文一路沿科技大道行驶绕行。\\n余杭径山段受径山枢纽合流影响，S14杭长（宜）高速径山段容易排队缓行，加上牛角山隧道影响，径山服务区段的缓行饱和状态明显，建议前往径山旅游的司乘人员，提前从S43杭州绕城西复线的瓶窑西收费站下高速，改走地方道路。\\n杭州公安高速交警提醒：高速行车，提前做好车况性能检查，提前规划路线，做全出行准备，合理规划出行时间、出行路线与出行方式，错峰文明出行。\\n高速行车，谨记“保命五条”：全员系好安全带，疲劳分心把命害，行车距离留余地，尾随货车生意外，违法停车危险来。发生故障或事故，“车靠边、人撤离、即报警”，三个动作必须\\n\"}]}', 1, 1, '2024-09-11 10:39:18', 0);
INSERT INTO `db_topic` VALUES (4, 'nishiwode', '{\"ops\":[{\"insert\":\"你是我的我是你的谁\\n\"}]}', 1, 2, '2024-09-17 16:04:06', 0);
INSERT INTO `db_topic` VALUES (5, '无语', '{\"ops\":[{\"insert\":\"大无语\\n\"}]}', 1, 5, '2024-09-17 16:08:51', 0);
INSERT INTO `db_topic` VALUES (6, '？？', '{\"ops\":[{\"insert\":\"！！！\\n\"}]}', 1, 3, '2024-09-17 16:09:33', 0);
INSERT INTO `db_topic` VALUES (7, 'dqwxad', '{\"ops\":[{\"insert\":\"阿道夫让大\\n\"}]}', 1, 1, '2024-09-17 16:11:04', 0);
INSERT INTO `db_topic` VALUES (8, '1223123', '{\"ops\":[{\"insert\":\"1111\\n\"}]}', 1, 1, '2024-09-17 16:33:46', 0);
INSERT INTO `db_topic` VALUES (9, '111', '{\"ops\":[{\"insert\":{\"image\":\"http://localhost:8080/images/cache/20240917/500fb87853e84025ae6da371b1d522ab\"}},{\"insert\":\"\\n\"}]}', 1, 1, '2024-09-17 16:48:10', 0);
INSERT INTO `db_topic` VALUES (10, 'eqweqwe', '{\"ops\":[{\"insert\":\"13123113\\n\"},{\"insert\":{\"image\":\"http://localhost:8080/images/cache/20240917/10450a33de324daba11ae339cf53d4b6\"}},{\"insert\":\"\\n33322313\\n\"},{\"insert\":{\"image\":\"http://localhost:8080/images/cache/20240917/f6a6343053a848bd8a81cba37dc72b37\"}},{\"insert\":\"\\n\"}]}', 1, 2, '2024-09-17 16:48:52', 0);
INSERT INTO `db_topic` VALUES (11, '312312312', '{\"ops\":[{\"insert\":{\"image\":\"http://localhost:8080/images/cache/20240917/1517e2dc247742ff8892cca21638c2a3\"}},{\"insert\":\"\\n21313123123\\n\"},{\"insert\":{\"image\":\"http://localhost:8080/images/cache/20240917/e2012e3e031b4c27b8ac0bf5e81c25f0\"}},{\"insert\":\"\\n\"}]}', 1, 2, '2024-09-17 16:49:11', 0);
INSERT INTO `db_topic` VALUES (12, '千万别再咸鱼到手刀', '{\"ops\":[{\"insert\":\"太坑了\\n\"}]}', 1, 5, '2024-09-17 22:04:16', 1);

-- ----------------------------
-- Table structure for db_topic_type
-- ----------------------------
DROP TABLE IF EXISTS `db_topic_type`;
CREATE TABLE `db_topic_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of db_topic_type
-- ----------------------------
INSERT INTO `db_topic_type` VALUES (1, '日常闲聊', '在这里分享你的各种日常', '#1E90FF');
INSERT INTO `db_topic_type` VALUES (2, '真诚交友', '在校园里寻找志同道合的朋友', '#CE1EFF');
INSERT INTO `db_topic_type` VALUES (3, '问题反馈', '反馈你在校园里遇到的问题', '#E07373');
INSERT INTO `db_topic_type` VALUES (4, '恋爱官宣', '向大家展示你的恋爱成果', '#E0CE73');
INSERT INTO `db_topic_type` VALUES (5, '踩坑记录', '将你遇到的坑分享给大家，防止其他人再次入坑', '#3BB62A');

SET FOREIGN_KEY_CHECKS = 1;
