/*
 Navicat Premium Data Transfer

 Source Server         : wmf
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : big_event

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 12/07/2024 14:18:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文章标题',
  `content` varchar(10000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文章内容',
  `cover_img` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文章封面',
  `state` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '草稿' COMMENT '文章状态: 只能是[已发布] 或者 [草稿]',
  `category_id` int UNSIGNED NULL DEFAULT NULL COMMENT '文章分类ID',
  `create_user` int UNSIGNED NOT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_article_category`(`category_id` ASC) USING BTREE,
  INDEX `fk_article_user`(`create_user` ASC) USING BTREE,
  CONSTRAINT `fk_article_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_article_user` FOREIGN KEY (`create_user`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES (1, '长沙旅游攻略', '<p>橘子洲头...爱去哪去哪...</p>', '/file/9617405df9c74f83bf7c7d59ace2da23.jpg', '已发布', 4, 1, '2024-07-05 14:01:38', '2024-07-12 11:55:47');
INSERT INTO `article` VALUES (2, '北京旅游攻略', '<p>天安门,颐和园,鸟巢,长城...爱去哪去哪...123456</p>', '/file/7d7ecf0c2f50416180b78bf5127a9c90.jpg', '草稿', 4, 1, '2024-07-05 14:02:57', '2024-07-12 11:46:30');
INSERT INTO `article` VALUES (3, '杭州旅游攻略', '<p>西湖...爱去哪去哪...123</p>', '/file/e12a326dd50949ad9c93b3bf448d633b.jpg', '已发布', 4, 1, '2024-07-05 14:27:46', '2024-07-12 11:46:36');
INSERT INTO `article` VALUES (5, '123', '<p>123</p>', '/file/cd4594a982a14250a702ccf73c90c026.jpg', '已发布', 1, 1, '2024-07-11 16:50:39', '2024-07-12 11:46:41');
INSERT INTO `article` VALUES (7, '789', '<p>789</p>', '/file/1c389cc6f0d64a9e98bbe2c05367322b.jpg', '已发布', 1, 1, '2024-07-12 11:08:46', '2024-07-12 11:08:46');
INSERT INTO `article` VALUES (8, '123', '<p>123</p>', '/file/7d7ecf0c2f50416180b78bf5127a9c90.jpg', '草稿', 8, 3, '2024-07-12 12:39:29', '2024-07-12 12:39:36');
INSERT INTO `article` VALUES (9, '123', '<p>123456</p>', '/file/dfd005b6018e4207a671e0991924145c.jpg', '草稿', 9, 4, '2024-07-12 13:48:26', '2024-07-12 13:48:29');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `category_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `category_alias` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类别名',
  `create_user` int UNSIGNED NOT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_category_user`(`create_user` ASC) USING BTREE,
  CONSTRAINT `fk_category_user` FOREIGN KEY (`create_user`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '美食', 'meishi', 1, '2024-07-05 14:00:08', '2024-07-11 14:06:16');
INSERT INTO `category` VALUES (2, '军事', 'js', 1, '2024-07-05 14:00:20', '2024-07-05 14:22:26');
INSERT INTO `category` VALUES (4, '旅游', 'ly', 1, '2024-07-05 14:00:49', '2024-07-05 14:00:49');
INSERT INTO `category` VALUES (5, '历史', 'ls', 1, '2024-07-11 11:10:36', '2024-07-11 11:10:36');
INSERT INTO `category` VALUES (6, '人文', 'rw', 1, '2024-07-11 11:11:00', '2024-07-11 11:11:00');
INSERT INTO `category` VALUES (7, '游戏', 'youxi', 1, '2024-07-11 14:06:32', '2024-07-11 14:06:38');
INSERT INTO `category` VALUES (8, '123', '123', 3, '2024-07-12 12:39:18', '2024-07-12 12:39:18');
INSERT INTO `category` VALUES (9, '历史', 'ls', 4, '2024-07-12 13:48:14', '2024-07-12 13:48:14');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `nickname` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '昵称',
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '邮箱',
  `user_pic` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '张三123', 'e10adc3949ba59abbe56e057f20f883e', 'zs', 'zs@163.com', '/file/1c389cc6f0d64a9e98bbe2c05367322b.jpg', '2024-07-04 16:28:13', '2024-07-12 13:47:25');
INSERT INTO `user` VALUES (2, '李四123', 'e10adc3949ba59abbe56e057f20f883e', '', '', '/file/1c389cc6f0d64a9e98bbe2c05367322b.jpg', '2024-07-10 19:14:16', '2024-07-12 12:37:48');
INSERT INTO `user` VALUES (3, '123456', 'e10adc3949ba59abbe56e057f20f883e', '', '', '/file/7d7ecf0c2f50416180b78bf5127a9c90.jpg', '2024-07-10 19:28:38', '2024-07-12 12:39:01');
INSERT INTO `user` VALUES (4, '王五123', 'e10adc3949ba59abbe56e057f20f883e', '', '', '/file/9490bf3a866046158568075fcbed6394.jpg', '2024-07-12 13:47:40', '2024-07-12 13:48:40');

SET FOREIGN_KEY_CHECKS = 1;
