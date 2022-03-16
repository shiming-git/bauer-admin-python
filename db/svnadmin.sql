/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : svnadmin

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 16/03/2022 22:33:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for mode_addres
-- ----------------------------
DROP TABLE IF EXISTS `mode_addres`;
CREATE TABLE `mode_addres`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `make_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '许愿ID',
  `user_name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人姓名',
  `postal_code` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮编 ',
  `province_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '国标收货地址第一级地址 ',
  `city_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '国标收货地址第二级地址 ',
  `county_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '国标收货地址第三级地址 ',
  `detail_info` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详细收货地址信息 ',
  `national_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货地址国家码 ',
  `tel_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人手机号码 ',
  `datetime` datetime(0) NULL DEFAULT NULL COMMENT '领取时间',
  `waybill` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单号 ',
  `wdatetime` datetime(0) NULL DEFAULT NULL COMMENT '订单时间 ',
  `start` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态  1领取 2发放 3',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updata_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `updata_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `create_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户认领地址表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mode_addres
-- ----------------------------

-- ----------------------------
-- Table structure for mode_class
-- ----------------------------
DROP TABLE IF EXISTS `mode_class`;
CREATE TABLE `mode_class`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `class_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类别名称',
  `class_sup` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类别父类',
  `class_sort` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '类别排序',
  `class_icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类别图标',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updata_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `updata_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `create_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mode_class
-- ----------------------------

-- ----------------------------
-- Table structure for mode_commodity
-- ----------------------------
DROP TABLE IF EXISTS `mode_commodity`;
CREATE TABLE `mode_commodity`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `com_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `com_img` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `com_price` decimal(65, 2) NULL DEFAULT NULL COMMENT '商品价格',
  `com_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品链接',
  `com_mainclass` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品主类',
  `com_subclass` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品子类',
  `com_details` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品详情',
  `com_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品归属',
  `com_is_state` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品状态(on上线 0ff等待上线)',
  `com_library` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '存储库 jd京东 tb淘宝 tm天猫 local本地',
  `com_data` datetime(0) NULL DEFAULT NULL COMMENT '商品日期',
  `com_text_deat` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '文字详情',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updata_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `updata_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `create_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mode_commodity
-- ----------------------------

-- ----------------------------
-- Table structure for mode_fontana
-- ----------------------------
DROP TABLE IF EXISTS `mode_fontana`;
CREATE TABLE `mode_fontana`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `font_stat_data` datetime(0) NULL DEFAULT NULL COMMENT '许愿时间',
  `font_numbar` bigint(0) NULL DEFAULT NULL COMMENT '许愿人数',
  `font_money` float(255, 2) NULL DEFAULT NULL COMMENT '许愿金额',
  `end_data` datetime(0) NULL DEFAULT NULL COMMENT '达成时间',
  `end_numbar` bigint(0) NULL DEFAULT NULL COMMENT '达成人数',
  `end_money` float(255, 2) NULL DEFAULT NULL COMMENT '达成金额',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updata_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `updata_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `create_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '许愿池表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mode_fontana
-- ----------------------------

-- ----------------------------
-- Table structure for mode_wxuser
-- ----------------------------
DROP TABLE IF EXISTS `mode_wxuser`;
CREATE TABLE `mode_wxuser`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `user_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户ID',
  `open_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户openid',
  `user_nick_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户网名',
  `user_avatar_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `user_gender` enum('0','1','2') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户性别（userGender）/性别 0：未知、1：男、2：女',
  `user_province` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户省份',
  `user_city` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户城市',
  `user_stat` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户状态0正常 1禁用 2黑名单',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updata_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `updata_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `create_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '微信用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mode_wxuser
-- ----------------------------

-- ----------------------------
-- Table structure for onl_dict
-- ----------------------------
DROP TABLE IF EXISTS `onl_dict`;
CREATE TABLE `onl_dict`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `table` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码',
  `describe` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '描述',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updata_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `updata_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `create_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据字典' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of onl_dict
-- ----------------------------
INSERT INTO `onl_dict` VALUES ('1', 'onl-表类型', 'onl_table_type', '表单开发 表类型', '2022-01-01 00:48:24', '2022-02-08 23:12:17', '超级管理员', NULL);
INSERT INTO `onl_dict` VALUES ('1504052205957812224', 'onl_表弹窗是否满屏', 'onl_table_full_screen', 'onl_表弹窗是否满屏', '2022-03-16 19:09:24', NULL, NULL, '超级管理员');
INSERT INTO `onl_dict` VALUES ('1504056718970195968', 'onl_表是否树', 'onl_table_is_tree', 'onl_表是否树', '2022-03-16 19:27:20', '2022-03-16 19:27:38', '超级管理员', '超级管理员');
INSERT INTO `onl_dict` VALUES ('1504061915016597504', 'onl_表字段类型', 'onl_table_field_type', '字段类型', '2022-03-16 19:47:59', NULL, NULL, '超级管理员');
INSERT INTO `onl_dict` VALUES ('1504068079808811008', 'onl_表控件类型', 'onl_table_control_type', '表控件类型', '2022-03-16 20:12:29', '2022-03-16 20:12:36', '超级管理员', '超级管理员');
INSERT INTO `onl_dict` VALUES ('1504074346832990208', '状态管理', 'sys_state', '0启用 1停用', '2022-03-16 20:37:23', '2022-03-16 20:42:09', '超级管理员', '超级管理员');
INSERT INTO `onl_dict` VALUES ('1504075684723691520', '用户状态管理', 'sys_user_state', '1正常 2审核 3停用', '2022-03-16 20:42:42', NULL, NULL, '超级管理员');
INSERT INTO `onl_dict` VALUES ('1504076763049889792', '性别管理', 'sys_sex', '值为1时是男性，值为2时是女性，值为0时是未知', '2022-03-16 20:46:59', NULL, NULL, '超级管理员');
INSERT INTO `onl_dict` VALUES ('2', 'onl-表分类', 'onl_table_class', '表单开发 表分类', '2022-01-01 00:49:43', NULL, NULL, NULL);
INSERT INTO `onl_dict` VALUES ('3', '单选框-是否', 'button_radio', '按钮单选框', '2022-01-01 00:51:05', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for onl_dict_field
-- ----------------------------
DROP TABLE IF EXISTS `onl_dict_field`;
CREATE TABLE `onl_dict_field`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `table` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码',
  `describe` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '描述',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updata_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `updata_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `create_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `dict_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of onl_dict_field
-- ----------------------------
INSERT INTO `onl_dict_field` VALUES ('1', '是', 'Y', '单选框-是', 1, '2022-01-01 00:52:10', NULL, NULL, NULL, 'button_radio');
INSERT INTO `onl_dict_field` VALUES ('1501600776928235520', '单表', 'single_table', '单表查询', 1, '2022-03-10 00:48:18', NULL, NULL, '超级管理员', 'onl_table_class');
INSERT INTO `onl_dict_field` VALUES ('1501600894238724096', '多表', 'multi_table', '多表查询', 2, '2022-03-10 00:48:46', NULL, NULL, '超级管理员', 'onl_table_class');
INSERT INTO `onl_dict_field` VALUES ('1501601196681596928', '树型表', 'tree_table', '树型表查询', 3, '2022-03-10 00:49:58', '2022-03-10 00:50:13', '超级管理员', '超级管理员', 'onl_table_class');
INSERT INTO `onl_dict_field` VALUES ('1501601507345305600', '主表', 'main_table', '主表', 1, '2022-03-10 00:51:12', NULL, NULL, '超级管理员', 'onl_table_type');
INSERT INTO `onl_dict_field` VALUES ('1501601613704466432', '子表', 'sub_table', '子表', 2, '2022-03-10 00:51:37', NULL, NULL, '超级管理员', 'onl_table_type');
INSERT INTO `onl_dict_field` VALUES ('1501601913446207488', '索引表', 'Index_table', '索引表', 3, '2022-03-10 00:52:49', NULL, NULL, '超级管理员', 'onl_table_type');
INSERT INTO `onl_dict_field` VALUES ('1504052433641410560', '是', 'Y', '是', 1, '2022-03-16 19:10:18', NULL, NULL, '超级管理员', 'onl_table_full_screen');
INSERT INTO `onl_dict_field` VALUES ('1504052482593132544', '否', 'N', '否', 2, '2022-03-16 19:10:30', NULL, NULL, '超级管理员', 'onl_table_full_screen');
INSERT INTO `onl_dict_field` VALUES ('1504056861794635776', '是', 'Y', NULL, 1, '2022-03-16 19:27:54', NULL, NULL, '超级管理员', 'onl_table_is_tree');
INSERT INTO `onl_dict_field` VALUES ('1504056894715727872', '否', 'N', NULL, 2, '2022-03-16 19:28:02', NULL, NULL, '超级管理员', 'onl_table_is_tree');
INSERT INTO `onl_dict_field` VALUES ('1504062050375176192', '字符串', 'varchar', NULL, 1, '2022-03-16 19:48:31', NULL, NULL, '超级管理员', 'onl_table_field_type');
INSERT INTO `onl_dict_field` VALUES ('1504062139269255168', '整数型', 'int', NULL, 2, '2022-03-16 19:48:52', '2022-03-16 19:49:05', '超级管理员', '超级管理员', 'onl_table_field_type');
INSERT INTO `onl_dict_field` VALUES ('1504062316667342848', '日期-时间', 'datetime', NULL, 4, '2022-03-16 19:49:35', '2022-03-16 19:49:57', '超级管理员', '超级管理员', 'onl_table_field_type');
INSERT INTO `onl_dict_field` VALUES ('1504062394542985216', '文本型', 'text', NULL, 3, '2022-03-16 19:49:53', NULL, NULL, '超级管理员', 'onl_table_field_type');
INSERT INTO `onl_dict_field` VALUES ('1504063145885437952', '双精度', 'double', NULL, 5, '2022-03-16 19:52:52', NULL, NULL, '超级管理员', 'onl_table_field_type');
INSERT INTO `onl_dict_field` VALUES ('1504063327897260032', '浮点型', 'decimal', NULL, 6, '2022-03-16 19:53:36', NULL, NULL, '超级管理员', 'onl_table_field_type');
INSERT INTO `onl_dict_field` VALUES ('1504068265339654144', '普通输入框', 'Input', '普通输入框', 1, '2022-03-16 20:13:13', '2022-03-16 20:34:55', '超级管理员', '超级管理员', 'onl_table_control_type');
INSERT INTO `onl_dict_field` VALUES ('1504068365625462784', '下拉框', 'select', '下拉框', 2, '2022-03-16 20:13:37', NULL, NULL, '超级管理员', 'onl_table_control_type');
INSERT INTO `onl_dict_field` VALUES ('1504068538716000256', '单选框', 'radio', '单选框', 3, '2022-03-16 20:14:18', '2022-03-16 20:15:11', '超级管理员', '超级管理员', 'onl_table_control_type');
INSERT INTO `onl_dict_field` VALUES ('1504068735831511040', '下拉搜索框', 'select_search', '下拉搜索框', 4, '2022-03-16 20:15:05', NULL, NULL, '超级管理员', 'onl_table_control_type');
INSERT INTO `onl_dict_field` VALUES ('1504069525887389696', '日期-时间选择', 'date_time', '日期-时间选择', 5, '2022-03-16 20:18:13', '2022-03-16 20:18:29', '超级管理员', '超级管理员', 'onl_table_control_type');
INSERT INTO `onl_dict_field` VALUES ('1504069664102289408', '日期选择', 'date', '日期选择', 6, '2022-03-16 20:18:46', '2022-03-16 20:19:12', '超级管理员', '超级管理员', 'onl_table_control_type');
INSERT INTO `onl_dict_field` VALUES ('1504069749015973888', '时间选择', 'time', '时间选择', 7, '2022-03-16 20:19:07', '2022-03-16 20:31:45', '超级管理员', '超级管理员', 'onl_table_control_type');
INSERT INTO `onl_dict_field` VALUES ('1504074665964998656', '启用', '0', NULL, 1, '2022-03-16 20:38:39', NULL, NULL, '超级管理员', 'sys_state');
INSERT INTO `onl_dict_field` VALUES ('1504075477797703680', '停用', '1', NULL, 2, '2022-03-16 20:41:52', NULL, NULL, '超级管理员', 'sys_state');
INSERT INTO `onl_dict_field` VALUES ('1504075719918096384', '正常', '1', NULL, 1, '2022-03-16 20:42:50', NULL, NULL, '超级管理员', 'sys_user_state');
INSERT INTO `onl_dict_field` VALUES ('1504075745952141312', '审核', '2', NULL, 2, '2022-03-16 20:42:56', '2022-03-16 20:43:09', '超级管理员', '超级管理员', 'sys_user_state');
INSERT INTO `onl_dict_field` VALUES ('1504075842286915584', '停用', '3', NULL, 3, '2022-03-16 20:43:19', NULL, NULL, '超级管理员', 'sys_user_state');
INSERT INTO `onl_dict_field` VALUES ('1504076814295896064', '男', '1', NULL, 1, '2022-03-16 20:47:11', NULL, NULL, '超级管理员', 'sys_sex');
INSERT INTO `onl_dict_field` VALUES ('1504076872672219136', '女', '2', NULL, 2, '2022-03-16 20:47:25', NULL, NULL, '超级管理员', 'sys_sex');
INSERT INTO `onl_dict_field` VALUES ('1504076911423393792', '未知', '0', NULL, 3, '2022-03-16 20:47:34', NULL, NULL, '超级管理员', 'sys_sex');
INSERT INTO `onl_dict_field` VALUES ('2', '否', 'N', '单选框-否', 2, '2022-01-01 00:53:51', NULL, NULL, NULL, 'button_radio');

-- ----------------------------
-- Table structure for onl_table
-- ----------------------------
DROP TABLE IF EXISTS `onl_table`;
CREATE TABLE `onl_table`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updata_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `updata_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `create_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `table_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表名',
  `table_describe` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '表描述',
  `table_edition` int(0) NULL DEFAULT NULL COMMENT '表版本',
  `table_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表类型',
  `table_state` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表状态',
  `table_paging` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否分页',
  `table_tree` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否树',
  `table_class` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表分类',
  `dialog_width` int(0) NULL DEFAULT NULL COMMENT '弹窗宽度',
  `dialog_full` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '弹窗是否全屏',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'on表名' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of onl_table
-- ----------------------------
INSERT INTO `onl_table` VALUES ('1482756754273079296', '2022-01-17 00:48:53', '2022-03-16 19:42:13', '超级管理员', '超级管理员', 'onl_table', 'on表单设计', 9, 'main_table', 'None', '是', '否', 'single_table', 800, 'Y');
INSERT INTO `onl_table` VALUES ('1482791317351305216', '2022-01-17 03:06:13', '2022-03-16 19:58:29', '超级管理员', '超级管理员', 'sys_role', '用户角色表', 15, 'single', NULL, 'Y', 'N', 'single', 800, 'N');
INSERT INTO `onl_table` VALUES ('1489554312228114432', '2022-02-04 18:59:57', '2022-03-16 20:47:57', '超级管理员', '超级管理员', 'sys_users', '用户表', 12, 'main_table', NULL, '是', '否', 'single_table', 800, 'N');
INSERT INTO `onl_table` VALUES ('1489554312228114433', '2022-02-04 18:59:57', NULL, NULL, '超级管理员', 'sys_role_model', '用户模块更新', 1, NULL, NULL, 'Y', 'Y', NULL, 800, 'N');
INSERT INTO `onl_table` VALUES ('1489554312228114434', '2022-02-04 18:59:57', NULL, NULL, '超级管理员', 'sys_role_user', '用户已角色关系表', 1, NULL, NULL, 'Y', 'Y', NULL, 800, 'N');
INSERT INTO `onl_table` VALUES ('1501558425862148096', '2022-03-09 22:00:00', '2022-03-16 20:17:18', '超级管理员', '超级管理员', 'sys_file', '文件管理', 10, 'main_table', NULL, '是', '否', 'single_table', 800, 'N');
INSERT INTO `onl_table` VALUES ('34e564bfd6da43c69c9ddc7ccfec160c', '2022-01-01 04:07:14', '2022-03-16 20:10:35', '超级管理员', '超级管理员', 'onl_dict_field', '字典字段', 2, 'sub_table', NULL, '是', '否', 'single_table', 800, 'N');
INSERT INTO `onl_table` VALUES ('41eb17dad04643b4b1f13c9ddc0660d6', '2022-01-01 04:07:14', '2022-02-08 22:28:49', '超级管理员', '超级管理员', 'onl_dict', '数据字典', 2, NULL, NULL, 'Y', 'Y', NULL, 800, 'N');
INSERT INTO `onl_table` VALUES ('6e13c500d939440fb1ddb92975f54493', '2022-01-01 03:40:25', NULL, NULL, '超级管理员', 'onl_table_field', 'onl字段名', 1, NULL, NULL, 'Y', 'Y', NULL, 800, 'N');

-- ----------------------------
-- Table structure for onl_table_field
-- ----------------------------
DROP TABLE IF EXISTS `onl_table_field`;
CREATE TABLE `onl_table_field`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `updata_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `updata_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `table_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表名',
  `field_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段名',
  `field_describe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段描述',
  `field_length` int(0) NULL DEFAULT NULL COMMENT '字段长度',
  `field_decimal` int(0) NULL DEFAULT NULL COMMENT '小数点',
  `field_default` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '默认值',
  `field_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段类型',
  `field_is_key` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否主键',
  `field_is_null` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '允许为空',
  `extra` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主键类型',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `show_form` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '显示表单',
  `show_list` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '显示列表',
  `is_sort` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否排序',
  `is_read_only` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否只读',
  `control_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '控件类型',
  `control_width` int(0) NULL DEFAULT NULL COMMENT '控件长度',
  `is_query` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否查询',
  `query_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询类型',
  `validation_rules` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '校验规则',
  `validation_required` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '校验必填',
  `dictionary_table` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典Table',
  `dictionary_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典Code',
  `dictionary_text` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典Text',
  `main_table_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主表名',
  `main_table_field` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主表字段',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'onl字段名' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of onl_table_field
-- ----------------------------
INSERT INTO `onl_table_field` VALUES ('09e23683018e4d23a6af7157099d8279', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'show_list', '显示列表', 20, 0, NULL, 'varchar', '', 'YES', '', 18, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('0e2d27187459404d900902b429314289', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'validation_rules', '校验规则', 255, 0, NULL, 'varchar', '', 'YES', '', 25, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('11767361e2a54137b513963a2b4e42fb', '2022-02-08 22:28:49', '超级管理员', '2022-02-08 22:28:49', '超级管理员', 'onl_dict', 'create_user', '创建人', 50, 0, NULL, 'varchar', '', 'YES', '', 8, 'Y', 'Y', 'Y', NULL, NULL, 200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1482756754390519808', '2022-03-16 19:42:13', '超级管理员', '2022-03-16 19:42:13', '超级管理员', 'onl_table', 'table_type', '表类型', 20, 0, 'None', 'varchar', '', 'YES', '', 9, 'Y', 'N', 'N', 'None', 'None', 0, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None');
INSERT INTO `onl_table_field` VALUES ('1482756754461822976', '2022-03-16 19:42:13', '超级管理员', '2022-03-16 19:42:13', '超级管理员', 'onl_table', 'table_tree', '是否树', 10, 0, 'None', 'varchar', '', 'YES', '', 12, 'Y', 'N', 'None', 'None', 'None', 0, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None');
INSERT INTO `onl_table_field` VALUES ('1482762031202439168', '2022-03-16 19:42:13', '超级管理员', '2022-03-16 19:42:13', '超级管理员', 'onl_table', 'id', '主键', 50, 0, 'None', 'varchar', 'PRI', 'NO', '', 1, 'Y', 'N', 'None', 'None', 'None', 0, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None');
INSERT INTO `onl_table_field` VALUES ('1482762031223410688', '2022-03-16 19:42:13', '超级管理员', '2022-03-16 19:42:13', '超级管理员', 'onl_table', 'table_name', '表名', 50, 0, 'None', 'varchar', '', 'YES', '', 6, 'Y', 'Y', 'Y', 'None', 'None', 0, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None');
INSERT INTO `onl_table_field` VALUES ('1482762031265353728', '2022-03-16 19:42:13', '超级管理员', '2022-03-16 19:42:13', '超级管理员', 'onl_table', 'table_describe', '表描述', 65535, 0, 'None', 'text', '', 'YES', '', 7, 'Y', 'Y', 'Y', 'None', 'None', 0, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None');
INSERT INTO `onl_table_field` VALUES ('1482762031282130944', '2022-03-16 19:42:13', '超级管理员', '2022-03-16 19:42:13', '超级管理员', 'onl_table', 'table_edition', '表版本', 0, 0, 'None', 'int', '', 'YES', '', 8, 'Y', 'Y', 'Y', 'None', 'None', 0, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None');
INSERT INTO `onl_table_field` VALUES ('1482762031336656896', '2022-03-16 19:42:13', '超级管理员', '2022-03-16 19:42:13', '超级管理员', 'onl_table', 'table_state', '表状态', 20, 0, 'None', 'varchar', '', 'YES', '', 10, 'N', 'N', 'N', 'None', 'None', 0, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None');
INSERT INTO `onl_table_field` VALUES ('1482762031353434112', '2022-03-16 19:42:13', '超级管理员', '2022-03-16 19:42:13', '超级管理员', 'onl_table', 'table_paging', '是否分页', 10, 0, 'None', 'varchar', '', 'YES', '', 11, 'Y', 'N', 'None', 'None', 'None', 0, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None');
INSERT INTO `onl_table_field` VALUES ('1482762031403765760', '2022-03-16 19:42:13', '超级管理员', '2022-03-16 19:42:13', '超级管理员', 'onl_table', 'table_class', '表分类', 10, 0, 'None', 'varchar', '', 'YES', '', 13, 'Y', 'N', 'None', 'None', 'None', 0, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None');
INSERT INTO `onl_table_field` VALUES ('1482762031420542976', '2022-03-16 19:42:13', '超级管理员', '2022-03-16 19:42:13', '超级管理员', 'onl_table', 'dialog_width', '弹窗宽度', 0, 0, 'None', 'int', '', 'YES', '', 14, 'Y', 'N', 'None', 'None', 'None', 0, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None');
INSERT INTO `onl_table_field` VALUES ('1482762031437320192', '2022-03-16 19:42:13', '超级管理员', '2022-03-16 19:42:13', '超级管理员', 'onl_table', 'dialog_full', '弹窗是否全屏', 10, 0, 'None', 'varchar', '', 'YES', '', 15, 'Y', 'N', 'None', 'None', 'None', 0, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None');
INSERT INTO `onl_table_field` VALUES ('1482762031458291712', '2022-03-16 19:42:13', '超级管理员', '2022-03-16 19:42:13', '超级管理员', 'onl_table', 'create_time', '创建时间', 0, 0, 'None', 'datetime', '', 'YES', '', 101, 'Y', 'Y', 'Y', 'None', 'None', 0, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None');
INSERT INTO `onl_table_field` VALUES ('1482762031470874624', '2022-03-16 19:42:13', '超级管理员', '2022-03-16 19:42:13', '超级管理员', 'onl_table', 'updata_time', '更新时间', 0, 0, 'None', 'datetime', '', 'YES', '', 102, 'Y', 'N', 'None', 'None', 'None', 0, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None');
INSERT INTO `onl_table_field` VALUES ('1482762031487651840', '2022-03-16 19:42:13', '超级管理员', '2022-03-16 19:42:13', '超级管理员', 'onl_table', 'updata_user', '更新人', 50, 0, 'None', 'varchar', '', 'YES', '', 103, 'Y', 'N', 'None', 'None', 'None', 0, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None');
INSERT INTO `onl_table_field` VALUES ('1482762031504429056', '2022-03-16 19:42:13', '超级管理员', '2022-03-16 19:42:13', '超级管理员', 'onl_table', 'create_user', '创建人', 50, 0, 'None', 'varchar', '', 'YES', '', 104, 'Y', 'Y', 'Y', 'None', 'None', 0, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None');
INSERT INTO `onl_table_field` VALUES ('1482791353476845568', '2022-03-16 19:58:29', '超级管理员', '2022-03-16 19:58:29', '超级管理员', 'sys_role', 'dataTime', '创建时间 ', 0, 0, NULL, 'datetime', '', 'YES', '', 5, 'Y', 'Y', 'Y', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1482791353476845569', '2022-03-16 19:58:29', '超级管理员', '2022-03-16 19:58:29', '超级管理员', 'sys_role', 'roleID', '角色ID', 0, 0, NULL, 'varchar', 'PRI', 'NO', 'auto_increment', 1, 'Y', NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1482791353476845570', '2022-03-16 19:58:29', '超级管理员', '2022-03-16 19:58:29', '超级管理员', 'sys_role', 'roleName', '角色名称 ', 50, 0, NULL, 'varchar', '', 'YES', '', 2, 'Y', 'Y', 'Y', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1482791353476845571', '2022-03-16 19:58:29', '超级管理员', '2022-03-16 19:58:29', '超级管理员', 'sys_role', 'roleSort', '角色排序', 0, 0, NULL, 'int', '', 'YES', '', 4, 'Y', 'Y', 'Y', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1482791353476845572', '2022-03-16 19:58:29', '超级管理员', '2022-03-16 19:58:29', '超级管理员', 'sys_role', 'roleStat', '角色状态', 1, 0, NULL, 'varchar', '', 'YES', '', 3, 'Y', 'Y', 'Y', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1489554312400080896', '2022-03-16 20:47:57', '超级管理员', '2022-03-16 20:47:57', '超级管理员', 'sys_users', 'avatarUrl', '用户头像', 255, 0, NULL, 'varchar', '', 'YES', '', 5, 'Y', 'Y', 'Y', NULL, NULL, 200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1489554312400080897', '2022-03-16 20:47:57', '超级管理员', '2022-03-16 20:47:57', '超级管理员', 'sys_users', 'loginDate', '登录时间', 0, 0, NULL, 'datetime', '', 'YES', '', 7, 'Y', 'Y', 'Y', NULL, NULL, 200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1489554312400080898', '2022-03-16 20:47:57', '超级管理员', '2022-03-16 20:47:57', '超级管理员', 'sys_users', 'loginState', '登录状态', 0, 0, NULL, 'int', '', 'YES', '', 10, 'N', 'N', 'N', NULL, NULL, 200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1489554312400080899', '2022-02-04 18:59:57', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'sys_role_model', 'modelID', '模块ID', NULL, 0, NULL, 'int', 'PRI', 'NO', '', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1489554312400080900', '2022-03-16 20:47:57', '超级管理员', '2022-03-16 20:47:57', '超级管理员', 'sys_users', 'newDate', '创建时间', 0, 0, NULL, 'datetime', '', 'YES', '', 6, 'Y', 'Y', 'Y', NULL, NULL, 200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1489554312400080901', '2022-03-16 20:47:57', '超级管理员', '2022-03-16 20:47:57', '超级管理员', 'sys_users', 'passWord', '用户密码', 255, 0, NULL, 'varchar', '', 'YES', '', 3, 'N', 'N', 'N', NULL, NULL, 200, NULL, NULL, NULL, 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1489554312400080902', '2022-03-16 20:47:57', '超级管理员', '2022-03-16 20:47:57', '超级管理员', 'sys_users', 'realName', '用户名称', 32, 0, NULL, 'varchar', '', 'YES', '', 4, 'Y', 'Y', 'Y', NULL, NULL, 200, 'Y', NULL, NULL, 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1489554312400080903', '2022-02-04 18:59:57', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'sys_role_model', 'roleID', '角色ID', NULL, 0, NULL, 'int', 'PRI', 'NO', '', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1489554312400080904', '2022-02-04 18:59:57', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'sys_role_user', 'roleID', '角色ID  ', NULL, 0, NULL, 'int', 'PRI', 'NO', '', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1489554312400080905', '2022-03-16 20:47:57', '超级管理员', '2022-03-16 20:47:57', '超级管理员', 'sys_users', 'sex', '性别', 0, 0, NULL, 'int', '', 'YES', '', 11, 'Y', 'Y', 'Y', NULL, NULL, 200, NULL, NULL, NULL, 'Y', NULL, 'sys_sex', NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1489554312400080906', '2022-03-16 20:47:57', '超级管理员', '2022-03-16 20:47:57', '超级管理员', 'sys_users', 'state', '状态', 0, 0, NULL, 'int', '', 'YES', '', 8, 'Y', 'Y', 'Y', NULL, NULL, 200, 'Y', NULL, NULL, 'Y', NULL, 'sys_user_state', NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1489554312400080907', '2022-02-04 18:59:57', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'sys_role_user', 'userID', '用户ID ', 50, 0, NULL, 'varchar', 'PRI', 'NO', '', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1489554312400080908', '2022-03-16 20:47:57', '超级管理员', '2022-03-16 20:47:57', '超级管理员', 'sys_users', 'userID', '用户ID', 50, 0, NULL, 'varchar', 'PRI', 'NO', '', 1, NULL, NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1489554312400080909', '2022-03-16 20:47:57', '超级管理员', '2022-03-16 20:47:57', '超级管理员', 'sys_users', 'userName', '用户账号', 32, 0, NULL, 'varchar', '', 'YES', '', 2, 'Y', 'Y', 'Y', NULL, NULL, 200, 'Y', NULL, NULL, 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1489554312400080910', '2022-03-16 20:47:57', '超级管理员', '2022-03-16 20:47:57', '超级管理员', 'sys_users', 'weixinUser', '绑定微信', 50, 0, NULL, 'varchar', '', 'YES', '', 9, 'Y', 'Y', 'Y', NULL, NULL, 200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1501558426038308864', '2022-03-16 20:17:18', '超级管理员', '2022-03-16 20:17:18', '超级管理员', 'sys_file', 'created_by', '创建人', 255, 0, NULL, 'varchar', '', 'YES', '', 5, 'Y', 'Y', 'Y', NULL, 'Input', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1501558426038308865', '2022-03-16 20:17:18', '超级管理员', '2022-03-16 20:17:18', '超级管理员', 'sys_file', 'created_date', '创建时间', 0, 0, NULL, 'datetime', '', 'YES', 'on update CURRENT_TIMESTAMP', 6, 'Y', 'Y', 'Y', NULL, 'Input', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1501558426038308866', '2022-03-16 20:17:18', '超级管理员', '2022-03-16 20:17:18', '超级管理员', 'sys_file', 'file_format', '文件格式', 50, 0, NULL, 'varchar', '', 'YES', '', 4, 'Y', 'Y', 'Y', NULL, 'Input', 0, 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1501558426038308867', '2022-03-16 20:17:18', '超级管理员', '2022-03-16 20:17:18', '超级管理员', 'sys_file', 'file_name', '文件名', 255, 0, NULL, 'varchar', '', 'NO', '', 2, 'Y', 'Y', 'Y', NULL, 'Input', 0, 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1501558426038308868', '2022-03-16 20:17:18', '超级管理员', '2022-03-16 20:17:18', '超级管理员', 'sys_file', 'file_original_name', '文件原始名', 255, 0, NULL, 'varchar', '', 'YES', '', 3, 'Y', 'Y', 'Y', NULL, 'Input', 0, 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1501558426038308869', '2022-03-16 20:17:18', '超级管理员', '2022-03-16 20:17:18', '超级管理员', 'sys_file', 'file_size', '文件大小', 0, 0, NULL, 'int', '', 'YES', '', 4, 'Y', 'Y', 'Y', NULL, 'Input', 0, 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1501558426038308870', '2022-03-16 20:17:18', '超级管理员', '2022-03-16 20:17:18', '超级管理员', 'sys_file', 'file_url', '文件路径', 255, 0, NULL, 'varchar', '', 'YES', '', 4, 'N', 'N', 'N', NULL, 'Input', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1501558426038308871', '2022-03-16 20:17:18', '超级管理员', '2022-03-16 20:17:18', '超级管理员', 'sys_file', 'id', 'ID ', 36, 0, NULL, 'varchar', 'PRI', 'NO', '', 1, NULL, NULL, NULL, NULL, 'Input', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('18ec0b1cfd5d4bd0a29ae80abfe444b3', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'field_length', '字段长度', NULL, 0, NULL, 'int', '', 'YES', '', 9, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1b06088cb5a74dd89c609cbfb9781e2f', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'field_type', '字段类型', 255, 0, NULL, 'varchar', '', 'YES', '', 12, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('1bc9d9bf9d344b7e9f04f036f1272a6f', '2022-03-16 20:10:35', '超级管理员', '2022-03-16 20:10:35', '超级管理员', 'onl_dict_field', 'sort', '排序', 0, 0, NULL, 'int', '', 'YES', '', 5, 'Y', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('22adf5954dd24731b13dca193cfb3452', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'show_form', '显示表单', 20, 0, NULL, 'varchar', '', 'YES', '', 17, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('372de80c007b4a2690af889639f40d38', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'main_table_name', '主表名', 255, 0, NULL, 'varchar', '', 'YES', '', 30, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('41e733a002404fef929fa873aac37243', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'field_describe', '字段描述', 255, 0, NULL, 'varchar', '', 'YES', '', 8, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('5b2cd39e7526418e909bb836c6388c56', '2022-02-08 22:28:49', '超级管理员', '2022-02-08 22:28:49', '超级管理员', 'onl_dict', 'create_time', '创建时间', 0, 0, NULL, 'datetime', '', 'YES', '', 5, 'Y', 'Y', 'Y', NULL, NULL, 200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('649ed372cba749cc8a37c54ce298722f', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'is_sort', '是否排序', 20, 0, NULL, 'varchar', '', 'YES', '', 19, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('656dd2939a8940a0b2f595d506dffb2c', '2022-02-08 22:28:49', '超级管理员', '2022-02-08 22:28:49', '超级管理员', 'onl_dict', 'id', '主键', 50, 0, NULL, 'varchar', 'PRI', 'NO', '', 1, 'N', 'N', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('6c47caa78fc14177a07a138f35846d95', '2022-03-16 20:10:35', '超级管理员', '2022-03-16 20:10:35', '超级管理员', 'onl_dict_field', 'code', '编码', 255, 0, NULL, 'varchar', '', 'YES', '', 3, 'Y', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('7635b4fc42874853b97089b28711b1bd', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'dictionary_text', '字典Text', 255, 0, NULL, 'varchar', '', 'YES', '', 29, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('78c516df062d479a8b4dcf511b7e7e6f', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'field_name', '字段名', 50, 0, NULL, 'varchar', '', 'YES', '', 7, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('7994e832efa74ba79a35bbe3542861b4', '2022-02-08 22:28:49', '超级管理员', '2022-02-08 22:28:49', '超级管理员', 'onl_dict', 'code', '编码', 255, 0, NULL, 'varchar', '', 'YES', '', 3, 'Y', 'Y', 'Y', NULL, NULL, 200, NULL, NULL, NULL, 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('7aa404e940804f8395b48492f952c91e', '2022-02-08 22:28:49', '超级管理员', '2022-02-08 22:28:49', '超级管理员', 'onl_dict', 'describe', '描述', 65535, 0, NULL, 'text', '', 'YES', '', 4, 'Y', 'Y', 'Y', NULL, NULL, 200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('7ba6e07497a14e8fb380f678f636a7b6', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'create_user', '创建人', 50, 0, NULL, 'varchar', '', 'YES', '', 3, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('7e1d61b818c544dda9ae08cf71021f1c', '2022-03-16 20:10:35', '超级管理员', '2022-03-16 20:10:35', '超级管理员', 'onl_dict_field', 'create_time', '创建时间', 0, 0, NULL, 'datetime', '', 'YES', '', 6, 'Y', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('7e9e396b912a4e22a73e0746d4bc3d11', '2022-02-08 22:28:49', '超级管理员', '2022-02-08 22:28:49', '超级管理员', 'onl_dict', 'updata_time', '更新时间', 0, 0, NULL, 'datetime', '', 'YES', '', 6, 'N', 'N', 'N', NULL, NULL, 200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('825797fb07004979b34678bf02e534f3', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'is_read_only', '是否只读', 20, 0, NULL, 'varchar', '', 'YES', '', 20, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('8dd5c7e73101424fa96cf1c3b5564c79', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'validation_required', '校验必填', 255, 0, NULL, 'varchar', '', 'YES', '', 26, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('9b293c70a7304b84beafbbad6ecf30d2', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'create_time', '创建时间', NULL, 0, NULL, 'datetime', '', 'YES', '', 2, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('9d4ef63512f94ba3b5ecd0cd80500ca5', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'field_default', '默认值', 255, 0, NULL, 'varchar', '', 'YES', '', 11, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('9f6b5c94c59845c2adcdd7cbd77205fa', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'table_name', '表名', 50, 0, NULL, 'varchar', '', 'YES', '', 6, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('a1b1755cb9724f018b508dba7ecb602e', '2022-03-16 20:10:35', '超级管理员', '2022-03-16 20:10:35', '超级管理员', 'onl_dict_field', 'table', '名称', 255, 0, NULL, 'varchar', '', 'YES', '', 2, 'Y', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('a444b8f5d5ea4e48bcc80e93b662e497', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'dictionary_table', '字典Table', 255, 0, NULL, 'varchar', '', 'YES', '', 27, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('a900bb5d8d504aa2bc4f90d0406a5c6d', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'field_is_null', '允许为空', 20, 0, NULL, 'varchar', '', 'YES', '', 14, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('b2770209d3fe44f8a4bee837c5a46cdf', '2022-02-08 22:28:49', '超级管理员', '2022-02-08 22:28:49', '超级管理员', 'onl_dict', 'table', '名称', 255, 0, NULL, 'varchar', '', 'YES', '', 2, 'Y', 'Y', 'Y', NULL, NULL, 200, NULL, NULL, NULL, 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('b3c8967f4ae242feae32db772ae7d149', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'is_query', '是否查询', 20, 0, NULL, 'varchar', '', 'YES', '', 23, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('b7c0a4da74524e7c8a9f603119770fa5', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'updata_user', '更新人', 50, 0, NULL, 'varchar', '', 'YES', '', 5, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('b8a21647117d42b6b38a86f84355b011', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'field_is_key', '是否主键', 20, 0, NULL, 'varchar', '', 'YES', '', 13, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('b917bbd3f2244f4c821f0400d730ec5a', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'extra', '主键类型', 50, 0, NULL, 'varchar', '', 'YES', '', 15, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('bb1fa41d41e34a9f9c8d633bb485f335', '2022-03-16 20:10:35', '超级管理员', '2022-03-16 20:10:35', '超级管理员', 'onl_dict_field', 'updata_user', '更新人', 50, 0, NULL, 'varchar', '', 'YES', '', 8, 'Y', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('bb9af51555164fb790a10226ac7568e0', '2022-03-16 20:10:35', '超级管理员', '2022-03-16 20:10:35', '超级管理员', 'onl_dict_field', 'id', '主键', 50, 0, NULL, 'varchar', 'PRI', 'NO', '', 1, 'Y', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('c41dbbe8d91e4da88c73f39d3826accc', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'dictionary_code', '字典Code', 255, 0, NULL, 'varchar', '', 'YES', '', 28, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('c6bb58ab65044ae3b09d6aeb25df5e4c', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'field_decimal', '小数点', NULL, 0, NULL, 'int', '', 'YES', '', 10, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('cc1637da7b724b42be64eac00695b080', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'updata_time', '更新时间', NULL, 0, NULL, 'datetime', '', 'YES', '', 4, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('cd756699cb1e4d0c858783971f952a65', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'sort', '排序', NULL, 0, NULL, 'int', '', 'YES', '', 16, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('ced2cd6ef82d4f8d8b2d3fc491b31147', '2022-03-16 20:10:35', '超级管理员', '2022-03-16 20:10:35', '超级管理员', 'onl_dict_field', 'dict_code', '字典编码', 255, 0, NULL, 'varchar', '', 'YES', '', 10, 'Y', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('da2047ef51094141a60e87dcf7179f22', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'id', '主键', 50, 0, NULL, 'varchar', 'PRI', 'NO', '', 1, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('dcc3cdd582d14997a39f4ee6017e6628', '2022-03-16 20:10:35', '超级管理员', '2022-03-16 20:10:35', '超级管理员', 'onl_dict_field', 'create_user', '创建人', 50, 0, NULL, 'varchar', '', 'YES', '', 9, 'Y', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('e508de9a7d104b7a8fb747363bb88f78', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'query_type', '查询类型', 255, 0, NULL, 'varchar', '', 'YES', '', 24, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('ea696ff927144947ae1bc8f9fde9a418', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'control_type', '控件类型', 50, 0, NULL, 'varchar', '', 'YES', '', 21, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('ed7e6e889ae148eab8ecd9e412038909', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'control_width', '控件长度', NULL, 0, NULL, 'int', '', 'YES', '', 22, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('eda065e583f145329761bc842423a84e', '2022-03-16 20:10:35', '超级管理员', '2022-03-16 20:10:35', '超级管理员', 'onl_dict_field', 'updata_time', '更新时间', 0, 0, NULL, 'datetime', '', 'YES', '', 7, 'Y', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('f3935c70470a4e56a2d7084529df9a43', '2022-03-16 20:10:35', '超级管理员', '2022-03-16 20:10:35', '超级管理员', 'onl_dict_field', 'describe', '描述', 65535, 0, NULL, 'text', '', 'YES', '', 4, 'Y', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('f7a925d99e18439d86069b6137a7e4c2', '2022-02-08 22:28:49', '超级管理员', '2022-02-08 22:28:49', '超级管理员', 'onl_dict', 'updata_user', '更新人', 50, 0, NULL, 'varchar', '', 'YES', '', 7, 'N', 'N', 'N', NULL, NULL, 200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `onl_table_field` VALUES ('fc58d02da6e74122a628957167f55635', '2022-01-01 03:40:25', 'f7de76ef4dab4a3288f7f8641ee6eed7', NULL, NULL, 'onl_table_field', 'main_table_field', '主表字段', 255, 0, NULL, 'varchar', '', 'YES', '', 31, 'Y', 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_choice_configure
-- ----------------------------
DROP TABLE IF EXISTS `sys_choice_configure`;
CREATE TABLE `sys_choice_configure`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '选项ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值',
  `sup` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分组',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '选项配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_choice_configure
-- ----------------------------
INSERT INTO `sys_choice_configure` VALUES (1, '站点弹窗', 'popup', 'sellerShow', 1);
INSERT INTO `sys_choice_configure` VALUES (2, '装扮', 'dressup', 'sellerShow', 2);
INSERT INTO `sys_choice_configure` VALUES (3, '开屏广告', 'screen', 'platformAdvertising', 1);
INSERT INTO `sys_choice_configure` VALUES (4, '聊天广告', 'chat', 'platformAdvertising', 2);
INSERT INTO `sys_choice_configure` VALUES (5, '激活', '1', 'activation', 1);
INSERT INTO `sys_choice_configure` VALUES (6, '暂停', '0', 'activation', 2);

-- ----------------------------
-- Table structure for sys_choice_group
-- ----------------------------
DROP TABLE IF EXISTS `sys_choice_group`;
CREATE TABLE `sys_choice_group`  (
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '组值',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组名称',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '选项组' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_choice_group
-- ----------------------------
INSERT INTO `sys_choice_group` VALUES ('activation', '是否激活', 3);
INSERT INTO `sys_choice_group` VALUES ('platformAdvertising', '平台广告', 2);
INSERT INTO `sys_choice_group` VALUES ('sellerShow', '站点广告', 1);

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `configOn` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配置编码',
  `configName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置名称',
  `configValue` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '配置属性',
  `configType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置类型',
  `configGroup` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置组名',
  PRIMARY KEY (`configOn`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统配置文件' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES ('weixiKey', '微信秘钥', '4567891321231', 'text', 'wx');
INSERT INTO `sys_config` VALUES ('weixiOpenId', '微信标识', '13456789', 'text', 'wx');

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file`  (
  `id` varchar(36) CHARACTER SET utf32 COLLATE utf32_general_ci NOT NULL COMMENT 'ID ',
  `file_name` varchar(255) CHARACTER SET utf32 COLLATE utf32_general_ci NOT NULL COMMENT '文件名',
  `file_original_name` varchar(255) CHARACTER SET utf32 COLLATE utf32_general_ci NULL DEFAULT NULL COMMENT '文件原始名',
  `file_size` int(0) NULL DEFAULT NULL COMMENT '文件大小',
  `created_by` varchar(255) CHARACTER SET utf32 COLLATE utf32_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `created_date` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `file_format` varchar(50) CHARACTER SET utf32 COLLATE utf32_general_ci NULL DEFAULT NULL COMMENT '文件格式',
  `file_url` varchar(255) CHARACTER SET utf32 COLLATE utf32_general_ci NULL DEFAULT NULL COMMENT '文件路径',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf32 COLLATE = utf32_general_ci COMMENT = '文件管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_file
-- ----------------------------
INSERT INTO `sys_file` VALUES ('1501225573027024896', '1501225573027024896.txt', '亚马逊页面APi请求链接.txt', 10289, '', '2022-03-08 23:57:22', 'txt', 'txt\\1501225573027024896.txt');
INSERT INTO `sys_file` VALUES ('1501235898539446272', '1501235898539446272.png', 'c9ad21d867d8f2af4e98a6145736f18.png', 11965, '', '2022-03-09 00:38:24', 'png', 'png\\1501235898539446272.png');
INSERT INTO `sys_file` VALUES ('1501236470042726400', '1501236470042726400.png', 'c9ad21d867d8f2af4e98a6145736f18.png', 11965, '', '2022-03-09 00:40:40', 'png', 'png\\1501236470042726400.png');
INSERT INTO `sys_file` VALUES ('1501236738494959616', '1501236738494959616.png', 'c9ad21d867d8f2af4e98a6145736f18.png', 11965, '', '2022-03-09 00:41:44', 'png', 'png\\1501236738494959616.png');

-- ----------------------------
-- Table structure for sys_model
-- ----------------------------
DROP TABLE IF EXISTS `sys_model`;
CREATE TABLE `sys_model`  (
  `modelID` int(0) NOT NULL AUTO_INCREMENT COMMENT '模块ID',
  `modelName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模块名称',
  `modelURL` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模块链接',
  `modelSup` int(0) NULL DEFAULT NULL COMMENT '父级模块',
  `modelSort` int(0) NOT NULL COMMENT '模块排序',
  `modelIcon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模块icon',
  `modelState` enum('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模块状态 0启用 1停用',
  `pageName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '页面名称',
  `modelPath` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模块路径',
  PRIMARY KEY (`modelID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '功能模块' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_model
-- ----------------------------
INSERT INTO `sys_model` VALUES (1, '系统管理', '/sys', -1, 1, 'el-icon-s-tools', '0', '/sys', '/index');
INSERT INTO `sys_model` VALUES (2, '营销管理', '/pages', -1, 2, 'el-icon-guide', '0', 'pages', '/pages');
INSERT INTO `sys_model` VALUES (4, '系统配置', '/sys/sysConfig', 1, 1, 'el-icon-set-up', '0', 'sys/sysConfig', '/sys/sysConfig');
INSERT INTO `sys_model` VALUES (5, '菜单管理', '/sys/modePage', 1, 2, 'el-icon-files', '0', 'sys/modePage', '/sys/modePage');
INSERT INTO `sys_model` VALUES (6, '聊天页面', '/pages/webSitePage', 2, 1, 'el-icon-chat-line-round', '0', 'pages/webSitePage', '/pages/webSitePage');
INSERT INTO `sys_model` VALUES (8, '客户留言', '/pages/guestBookPage', 2, 2, 'el-icon-chat-line-square', '0', 'pages/guestBookPage', '/pages/guestBookPage');
INSERT INTO `sys_model` VALUES (9, '配置参数', '/sys/sysChoiceConfigure', 1, 4, 'el-icon-notebook-2', '0', 'sysChoiceConfigure', '/sys/sysChoiceConfigure');
INSERT INTO `sys_model` VALUES (10, '配置分组', '/sys/sysChoiceGroup', 1, 3, 'el-icon-receiving', '0', 'sys/sysChoiceGroup', '/sys/sysChoiceGroup');
INSERT INTO `sys_model` VALUES (11, '角色管理', '/sys/sysRole', 1, 5, 'el-icon-help', '0', 'sys/sysRole', '/sys/sysRole');
INSERT INTO `sys_model` VALUES (12, '用户管理', '/sys/sysUser', 1, 6, 'el-icon-user', '0', 'sys/sysUser', '/sys/sysUser');
INSERT INTO `sys_model` VALUES (18, 'online', '/online', -1, 3, 'el-icon-cpu', '0', 'online', '/online');
INSERT INTO `sys_model` VALUES (19, '在线开发', '/online/onlTable', 18, 1, 'el-icon-document-remove', '0', 'online/onlTable', '/online/onlTable');
INSERT INTO `sys_model` VALUES (20, '数据字典', '/online/OnlDictList', 18, 2, 'el-icon-collection', '0', 'online\\OnlDictList', '/online/OnlDictList');
INSERT INTO `sys_model` VALUES (21, '文件管理', '/sys/sysFileList', 1, 7, 'el-icon-folder-opened', '0', 'sysFileList', '/sys/sysFileList');

-- ----------------------------
-- Table structure for sys_public
-- ----------------------------
DROP TABLE IF EXISTS `sys_public`;
CREATE TABLE `sys_public`  (
  `pubOn` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配置编码',
  `pubName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置名称',
  `pubValue` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '配置属性',
  `pubType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置类型',
  `pubGroup` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pubOn`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '配置分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_public
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `roleID` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `roleName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称 ',
  `dataTime` datetime(0) NULL DEFAULT NULL COMMENT '创建时间 ',
  `roleSort` int(0) NULL DEFAULT NULL COMMENT '角色排序',
  `roleStat` enum('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色状态  0启用 1停用',
  PRIMARY KEY (`roleID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', '2021-12-25 23:57:34', 1, '0');
INSERT INTO `sys_role` VALUES (10, '测试22', '2021-12-23 02:41:09', 2, '0');

-- ----------------------------
-- Table structure for sys_role_model
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_model`;
CREATE TABLE `sys_role_model`  (
  `roleID` int(0) NOT NULL COMMENT '角色ID',
  `modelID` int(0) NOT NULL COMMENT '模块ID',
  PRIMARY KEY (`roleID`, `modelID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户模块更新' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_model
-- ----------------------------
INSERT INTO `sys_role_model` VALUES (1, 1);
INSERT INTO `sys_role_model` VALUES (1, 2);
INSERT INTO `sys_role_model` VALUES (1, 4);
INSERT INTO `sys_role_model` VALUES (1, 5);
INSERT INTO `sys_role_model` VALUES (1, 6);
INSERT INTO `sys_role_model` VALUES (1, 8);
INSERT INTO `sys_role_model` VALUES (1, 9);
INSERT INTO `sys_role_model` VALUES (1, 10);
INSERT INTO `sys_role_model` VALUES (1, 11);
INSERT INTO `sys_role_model` VALUES (1, 12);
INSERT INTO `sys_role_model` VALUES (1, 18);
INSERT INTO `sys_role_model` VALUES (1, 19);
INSERT INTO `sys_role_model` VALUES (1, 20);
INSERT INTO `sys_role_model` VALUES (1, 21);
INSERT INTO `sys_role_model` VALUES (7, 13);
INSERT INTO `sys_role_model` VALUES (7, 15);
INSERT INTO `sys_role_model` VALUES (10, 1);
INSERT INTO `sys_role_model` VALUES (10, 4);
INSERT INTO `sys_role_model` VALUES (10, 6);
INSERT INTO `sys_role_model` VALUES (10, 9);
INSERT INTO `sys_role_model` VALUES (10, 13);
INSERT INTO `sys_role_model` VALUES (10, 15);

-- ----------------------------
-- Table structure for sys_role_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_user`;
CREATE TABLE `sys_role_user`  (
  `roleID` int(0) NOT NULL COMMENT '角色ID  ',
  `userID` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户ID ',
  PRIMARY KEY (`roleID`, `userID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户已角色关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_user
-- ----------------------------
INSERT INTO `sys_role_user` VALUES (1, 'f7de76ef4dab4a3288f7f8641ee6eed7');

-- ----------------------------
-- Table structure for sys_users
-- ----------------------------
DROP TABLE IF EXISTS `sys_users`;
CREATE TABLE `sys_users`  (
  `userID` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户ID',
  `userName` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户账号',
  `passWord` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户密码',
  `realName` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名称',
  `avatarUrl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `newDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `loginDate` datetime(0) NULL DEFAULT NULL COMMENT '登录时间',
  `state` int(0) NULL DEFAULT NULL COMMENT '状态 1正常 2审核 3停用',
  `weixinUser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '绑定微信',
  `loginState` int(0) NULL DEFAULT NULL COMMENT '登录状态',
  `sex` int(0) NULL DEFAULT NULL COMMENT '用户的性别 值为1时是男性，值为2时是女性，值为0时是未知',
  PRIMARY KEY (`userID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_users
-- ----------------------------
INSERT INTO `sys_users` VALUES ('6f21ae1bc38b469eb01d1574ca0d9ae8', '13189740104', '80c9900986939611', '店小二', NULL, '2021-07-24 17:20:26', '2021-07-26 09:04:46', 1, NULL, 1, 0);
INSERT INTO `sys_users` VALUES ('f7de76ef4dab4a3288f7f8641ee6eed7', 'admin', '5f79db0df976466cb7e01e2b60710d93', '超级管理员', NULL, '2021-07-22 19:27:21', '2021-10-20 12:05:45', 1, NULL, 1, 0);

-- ----------------------------
-- Table structure for weixin_users
-- ----------------------------
DROP TABLE IF EXISTS `weixin_users`;
CREATE TABLE `weixin_users`  (
  `openid` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户的标识',
  `subscribe` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户是否订阅该公众号标识，值为0时，代表此用户没有关注该公众号',
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户的昵称',
  `sex` enum('0','1','2') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户的性别 值为1时是男性，值为2时是女性，值为0时是未知',
  `city` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户所在城市',
  `country` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户所在国家',
  `province` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户所在省份',
  `language` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户的语言',
  `headimgurl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `subscribe_time` bigint(0) NULL DEFAULT NULL COMMENT '用户关注时间，为时间戳',
  `unionid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '只有在用户将公众号绑定到微信开放平台帐号后',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公众号运营者对粉丝的备注',
  `groupid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户所在的分组ID',
  `tagid_list` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户被打上的标签ID列表',
  `subscribe_scene` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '返回用户关注的渠道来源，ADD_SCENE_SEARCH 公众号搜索，ADD_SCENE_ACCOUNT_MIGRATION 公众号迁移，ADD_SCENE_PROFILE_CARD 名片分享，ADD_SCENE_QR_CODE 扫描二维码，ADD_SCENE_PROFILE_LINK 图文页内名称点击，',
  `qr_scene` int(0) NULL DEFAULT NULL COMMENT '二维码扫码场景',
  `qr_scene_str` varchar(70) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '二维码扫码场景描述',
  `newDate` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`openid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '微信用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of weixin_users
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
