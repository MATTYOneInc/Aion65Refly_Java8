-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Апр 24 2025 г., 18:48
-- Версия сервера: 5.7.39
-- Версия PHP: 8.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `aion65_game`
--

-- --------------------------------------------------------

--
-- Структура таблицы `abyss_rank`
--

CREATE TABLE `abyss_rank` (
  `player_id` int(11) NOT NULL,
  `daily_ap` int(11) NOT NULL,
  `daily_gp` int(11) NOT NULL,
  `weekly_ap` int(11) NOT NULL,
  `weekly_gp` int(11) NOT NULL,
  `ap` int(11) NOT NULL,
  `gp` int(11) NOT NULL,
  `rank` int(2) NOT NULL DEFAULT '1',
  `top_ranking` int(4) NOT NULL,
  `daily_kill` int(5) NOT NULL,
  `weekly_kill` int(5) NOT NULL,
  `all_kill` int(4) NOT NULL DEFAULT '0',
  `max_rank` int(2) NOT NULL DEFAULT '1',
  `last_kill` int(5) NOT NULL,
  `last_ap` int(11) NOT NULL,
  `last_gp` int(11) NOT NULL,
  `last_update` decimal(20,0) NOT NULL,
  `rank_pos` int(11) NOT NULL DEFAULT '0',
  `old_rank_pos` int(11) NOT NULL DEFAULT '0',
  `rank_ap` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `announcements`
--

CREATE TABLE `announcements` (
  `id` int(3) NOT NULL,
  `announce` text NOT NULL,
  `faction` enum('ALL','ASMODIANS','ELYOS') NOT NULL DEFAULT 'ALL',
  `type` enum('SHOUT','ORANGE','YELLOW','WHITE','SYSTEM') NOT NULL DEFAULT 'SYSTEM',
  `delay` int(4) NOT NULL DEFAULT '1800'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `banned_hdd`
--

CREATE TABLE `banned_hdd` (
  `uniId` int(10) NOT NULL,
  `hdd_serial` varchar(50) NOT NULL,
  `time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `details` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `base_location`
--

CREATE TABLE `base_location` (
  `id` int(11) NOT NULL,
  `race` enum('ELYOS','ASMODIANS','NPC') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `blocks`
--

CREATE TABLE `blocks` (
  `player` int(11) NOT NULL,
  `blocked_player` int(11) NOT NULL,
  `reason` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `bookmark`
--

CREATE TABLE `bookmark` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `char_id` int(11) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `world_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `broker`
--

CREATE TABLE `broker` (
  `id` int(11) NOT NULL,
  `item_pointer` int(11) NOT NULL DEFAULT '0',
  `item_id` int(11) NOT NULL,
  `item_count` bigint(20) NOT NULL,
  `item_creator` varchar(50) DEFAULT NULL,
  `seller` varchar(50) DEFAULT NULL,
  `price` bigint(20) NOT NULL DEFAULT '0',
  `broker_race` enum('ELYOS','ASMODIAN') NOT NULL,
  `expire_time` timestamp NOT NULL DEFAULT '2009-12-31 23:00:00',
  `settle_time` timestamp NOT NULL DEFAULT '2009-12-31 23:00:00',
  `seller_id` int(11) NOT NULL,
  `is_sold` tinyint(1) NOT NULL,
  `is_settled` tinyint(1) NOT NULL,
  `is_partsale` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `challenge_tasks`
--

CREATE TABLE `challenge_tasks` (
  `task_id` int(11) NOT NULL,
  `quest_id` int(10) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `owner_type` enum('LEGION','TOWN') NOT NULL,
  `complete_count` int(3) UNSIGNED NOT NULL DEFAULT '0',
  `complete_time` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `craft_cooldowns`
--

CREATE TABLE `craft_cooldowns` (
  `player_id` int(11) NOT NULL,
  `delay_id` int(11) UNSIGNED NOT NULL,
  `reuse_time` bigint(13) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `event_items`
--

CREATE TABLE `event_items` (
  `player_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `counts` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `f2paccount`
--

CREATE TABLE `f2paccount` (
  `account_id` int(11) NOT NULL,
  `time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `friends`
--

CREATE TABLE `friends` (
  `player` int(11) NOT NULL,
  `friend` int(11) NOT NULL,
  `note` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `guides`
--

CREATE TABLE `guides` (
  `guide_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `title` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `guild_quests`
--

CREATE TABLE `guild_quests` (
  `player_id` int(11) NOT NULL,
  `guild_id` int(2) NOT NULL DEFAULT '0',
  `recently_taken_quest` int(6) NOT NULL DEFAULT '0',
  `completion_timestamp` timestamp NULL DEFAULT NULL,
  `currently_started_quest` int(6) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `houses`
--

CREATE TABLE `houses` (
  `id` int(10) NOT NULL,
  `player_id` int(10) NOT NULL DEFAULT '0',
  `building_id` int(10) NOT NULL,
  `address` int(10) NOT NULL,
  `acquire_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `settings` int(11) NOT NULL DEFAULT '0',
  `status` enum('ACTIVE','SELL_WAIT','INACTIVE','NOSALE') NOT NULL DEFAULT 'ACTIVE',
  `fee_paid` tinyint(1) NOT NULL DEFAULT '1',
  `next_pay` timestamp NULL DEFAULT NULL,
  `sell_started` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `sign_notice` text CHARACTER SET utf16le
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `house_bids`
--

CREATE TABLE `house_bids` (
  `player_id` int(10) NOT NULL,
  `house_id` int(10) NOT NULL,
  `bid` bigint(20) NOT NULL,
  `bid_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `house_object_cooldowns`
--

CREATE TABLE `house_object_cooldowns` (
  `player_id` int(11) NOT NULL,
  `object_id` int(11) NOT NULL,
  `reuse_time` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `house_scripts`
--

CREATE TABLE `house_scripts` (
  `house_id` int(11) NOT NULL,
  `index` tinyint(4) NOT NULL,
  `script` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8 KEY_BLOCK_SIZE=16 ROW_FORMAT=COMPRESSED;

-- --------------------------------------------------------

--
-- Структура таблицы `inventory`
--

CREATE TABLE `inventory` (
  `item_unique_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_count` bigint(20) NOT NULL DEFAULT '0',
  `item_color` int(11) NOT NULL DEFAULT '0',
  `color_expires` int(11) NOT NULL DEFAULT '0',
  `item_creator` varchar(50) DEFAULT NULL,
  `expire_time` int(11) NOT NULL DEFAULT '0',
  `activation_count` int(11) NOT NULL DEFAULT '0',
  `item_owner` int(11) NOT NULL,
  `is_equiped` tinyint(1) NOT NULL DEFAULT '0',
  `is_soul_bound` tinyint(1) NOT NULL DEFAULT '0',
  `slot` bigint(20) NOT NULL DEFAULT '0',
  `item_location` tinyint(1) DEFAULT '0',
  `enchant` tinyint(1) DEFAULT '0',
  `item_skin` int(11) NOT NULL DEFAULT '0',
  `fusioned_item` int(11) NOT NULL DEFAULT '0',
  `optional_socket` int(1) NOT NULL DEFAULT '0',
  `optional_fusion_socket` int(1) NOT NULL DEFAULT '0',
  `charge` mediumint(9) NOT NULL DEFAULT '0',
  `rnd_bonus` smallint(6) DEFAULT NULL,
  `rnd_count` smallint(6) NOT NULL DEFAULT '0',
  `pack_count` smallint(6) NOT NULL DEFAULT '0',
  `authorize` int(11) NOT NULL DEFAULT '0',
  `is_packed` tinyint(1) NOT NULL DEFAULT '0',
  `is_amplified` tinyint(1) NOT NULL DEFAULT '0',
  `buff_skill` int(11) NOT NULL DEFAULT '0',
  `reduction_level` int(11) NOT NULL,
  `luna_reskin` tinyint(1) NOT NULL DEFAULT '0',
  `isEnhance` tinyint(1) NOT NULL DEFAULT '0',
  `enhanceSkillId` int(11) NOT NULL DEFAULT '0',
  `enhanceSkillEnchant` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `item_cooldowns`
--

CREATE TABLE `item_cooldowns` (
  `player_id` int(11) NOT NULL,
  `delay_id` int(11) NOT NULL,
  `use_delay` int(10) UNSIGNED NOT NULL,
  `reuse_time` bigint(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `item_stones`
--

CREATE TABLE `item_stones` (
  `item_unique_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `slot` int(2) NOT NULL,
  `category` int(2) NOT NULL DEFAULT '0',
  `polishNumber` int(11) NOT NULL DEFAULT '0',
  `polishCharge` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `legions`
--

CREATE TABLE `legions` (
  `id` int(11) NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `level` int(1) NOT NULL DEFAULT '1',
  `contribution_points` bigint(20) NOT NULL DEFAULT '0',
  `deputy_permission` int(11) NOT NULL DEFAULT '7692',
  `centurion_permission` int(11) NOT NULL DEFAULT '7176',
  `legionary_permission` int(11) NOT NULL DEFAULT '6144',
  `volunteer_permission` int(11) NOT NULL DEFAULT '2048',
  `disband_time` int(11) NOT NULL DEFAULT '0',
  `rank_cp` int(11) NOT NULL DEFAULT '0',
  `rank_pos` int(11) NOT NULL DEFAULT '0',
  `old_rank_pos` int(11) NOT NULL DEFAULT '0',
  `world_owner` int(11) NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL DEFAULT '',
  `joinType` int(1) NOT NULL DEFAULT '0',
  `minJoinLevel` int(3) NOT NULL DEFAULT '0',
  `territory` int(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `legion_announcement_list`
--

CREATE TABLE `legion_announcement_list` (
  `legion_id` int(11) NOT NULL,
  `announcement` varchar(256) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `legion_emblems`
--

CREATE TABLE `legion_emblems` (
  `legion_id` int(11) NOT NULL,
  `emblem_id` int(1) NOT NULL DEFAULT '0',
  `color_r` int(3) NOT NULL DEFAULT '0',
  `color_g` int(3) NOT NULL DEFAULT '0',
  `color_b` int(3) NOT NULL DEFAULT '0',
  `emblem_type` enum('DEFAULT','CUSTOM') NOT NULL DEFAULT 'DEFAULT',
  `emblem_data` longblob
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `legion_history`
--

CREATE TABLE `legion_history` (
  `id` int(11) NOT NULL,
  `legion_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `history_type` enum('CREATE','JOIN','KICK','APPOINTED','EMBLEM_REGISTER','EMBLEM_MODIFIED','ITEM_DEPOSIT','ITEM_WITHDRAW','KINAH_DEPOSIT','KINAH_WITHDRAW','LEVEL_UP') NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `tab_id` smallint(3) NOT NULL DEFAULT '0',
  `description` varchar(30) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `legion_join_requests`
--

CREATE TABLE `legion_join_requests` (
  `legionId` int(11) NOT NULL DEFAULT '0',
  `playerId` int(11) NOT NULL DEFAULT '0',
  `playerName` varchar(64) NOT NULL DEFAULT '',
  `playerClassId` int(2) NOT NULL DEFAULT '0',
  `playerRaceId` int(2) NOT NULL DEFAULT '0',
  `playerLevel` int(4) NOT NULL DEFAULT '0',
  `playerGenderId` int(2) NOT NULL DEFAULT '0',
  `joinRequestMsg` varchar(40) NOT NULL DEFAULT '',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `legion_members`
--

CREATE TABLE `legion_members` (
  `legion_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `nickname` varchar(10) NOT NULL DEFAULT '',
  `rank` enum('BRIGADE_GENERAL','CENTURION','LEGIONARY','DEPUTY','VOLUNTEER') NOT NULL DEFAULT 'VOLUNTEER',
  `selfintro` varchar(32) DEFAULT '',
  `challenge_score` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `mail`
--

CREATE TABLE `mail` (
  `mail_unique_id` int(11) NOT NULL,
  `mail_recipient_id` int(11) NOT NULL,
  `sender_name` varchar(26) NOT NULL,
  `mail_title` varchar(32) NOT NULL,
  `mail_message` varchar(1000) NOT NULL,
  `unread` tinyint(4) NOT NULL DEFAULT '1',
  `attached_item_id` int(11) NOT NULL,
  `attached_kinah_count` bigint(20) NOT NULL,
  `express` tinyint(4) NOT NULL DEFAULT '0',
  `recieved_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `network_ban`
--

CREATE TABLE `network_ban` (
  `uniId` int(10) NOT NULL,
  `ip` varchar(50) NOT NULL,
  `time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `details` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `old_names`
--

CREATE TABLE `old_names` (
  `id` int(11) UNSIGNED NOT NULL,
  `player_id` int(11) NOT NULL,
  `old_name` varchar(50) NOT NULL,
  `new_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `petitions`
--

CREATE TABLE `petitions` (
  `id` bigint(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `add_data` varchar(255) DEFAULT NULL,
  `time` bigint(11) NOT NULL DEFAULT '0',
  `status` enum('PENDING','IN_PROGRESS','REPLIED') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `players`
--

CREATE TABLE `players` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `account_id` int(11) NOT NULL,
  `account_name` varchar(50) NOT NULL,
  `exp` bigint(20) NOT NULL DEFAULT '0',
  `recoverexp` bigint(20) NOT NULL DEFAULT '0',
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `heading` int(11) NOT NULL,
  `world_id` int(11) NOT NULL,
  `world_owner` int(11) NOT NULL DEFAULT '0',
  `gender` enum('MALE','FEMALE') NOT NULL,
  `race` enum('ASMODIANS','ELYOS') NOT NULL,
  `player_class` enum('WARRIOR','GLADIATOR','TEMPLAR','SCOUT','ASSASSIN','RANGER','MAGE','SORCERER','SPIRIT_MASTER','PRIEST','CLERIC','CHANTER','ENGINEER','GUNNER','ARTIST','BARD','RIDER','ALL') NOT NULL,
  `creation_date` timestamp NULL DEFAULT NULL,
  `deletion_date` timestamp NULL DEFAULT NULL,
  `last_online` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `cube_expands` tinyint(1) NOT NULL DEFAULT '0',
  `advanced_stigma_slot_size` tinyint(1) NOT NULL DEFAULT '0',
  `warehouse_size` tinyint(1) NOT NULL DEFAULT '0',
  `mailbox_letters` tinyint(4) UNSIGNED NOT NULL DEFAULT '0',
  `title_id` int(3) NOT NULL DEFAULT '-1',
  `bonus_title_id` int(3) NOT NULL DEFAULT '-1',
  `dp` int(3) NOT NULL DEFAULT '0',
  `soul_sickness` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `reposte_energy` bigint(20) NOT NULL DEFAULT '0',
  `goldenstar_energy` bigint(20) NOT NULL DEFAULT '0',
  `growth_energy` bigint(20) NOT NULL DEFAULT '0',
  `bg_points` int(11) NOT NULL DEFAULT '0',
  `online` tinyint(1) NOT NULL DEFAULT '0',
  `note` text,
  `mentor_flag_time` int(11) NOT NULL DEFAULT '0',
  `initial_gamestats` int(11) NOT NULL DEFAULT '0',
  `last_transfer_time` decimal(20,0) NOT NULL DEFAULT '0',
  `fatigue` int(11) NOT NULL DEFAULT '0',
  `fatigueRecover` int(11) NOT NULL DEFAULT '0',
  `fatigueReset` int(11) NOT NULL DEFAULT '0',
  `joinRequestLegionId` int(11) NOT NULL DEFAULT '0',
  `joinRequestState` enum('NONE','DENIED','ACCEPTED') NOT NULL DEFAULT 'NONE',
  `frenzy_points` int(4) NOT NULL DEFAULT '0' COMMENT 'Upgrade Arcade FrenzyPoints',
  `frenzy_count` int(1) NOT NULL DEFAULT '0',
  `show_inventory` int(1) NOT NULL DEFAULT '1',
  `bonus_buff_time` timestamp NULL DEFAULT NULL,
  `bonus_type` enum('RETURN','NEW','NORMAL') NOT NULL DEFAULT 'NORMAL',
  `wardrobe_size` int(4) NOT NULL,
  `wardrobe_slot` int(11) NOT NULL DEFAULT '2',
  `luna_consume_count` int(11) NOT NULL DEFAULT '0',
  `muni_keys` int(11) NOT NULL DEFAULT '0',
  `luna_consume` int(11) NOT NULL DEFAULT '0',
  `toc_floor` int(11) NOT NULL DEFAULT '0',
  `minion_skill_points` int(5) NOT NULL DEFAULT '0',
  `minion_function_time` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_appearance`
--

CREATE TABLE `player_appearance` (
  `player_id` int(11) NOT NULL,
  `voice` int(11) NOT NULL,
  `skin_rgb` int(11) NOT NULL,
  `hair_rgb` int(11) NOT NULL,
  `eye_rgb` int(11) NOT NULL,
  `lip_rgb` int(11) NOT NULL,
  `face` int(11) NOT NULL,
  `hair` int(11) NOT NULL,
  `deco` int(11) NOT NULL,
  `tattoo` int(11) NOT NULL,
  `face_contour` int(11) NOT NULL,
  `expression` int(11) NOT NULL,
  `pupil_shape` int(11) NOT NULL,
  `remove_mane` int(11) NOT NULL,
  `right_eye_rgb` int(11) NOT NULL,
  `eye_lash_shape` int(11) NOT NULL,
  `jaw_line` int(11) NOT NULL,
  `forehead` int(11) NOT NULL,
  `eye_height` int(11) NOT NULL,
  `eye_space` int(11) NOT NULL,
  `eye_width` int(11) NOT NULL,
  `eye_size` int(11) NOT NULL,
  `eye_shape` int(11) NOT NULL,
  `eye_angle` int(11) NOT NULL,
  `brow_height` int(11) NOT NULL,
  `brow_angle` int(11) NOT NULL,
  `brow_shape` int(11) NOT NULL,
  `nose` int(11) NOT NULL,
  `nose_bridge` int(11) NOT NULL,
  `nose_width` int(11) NOT NULL,
  `nose_tip` int(11) NOT NULL,
  `cheek` int(11) NOT NULL,
  `lip_height` int(11) NOT NULL,
  `mouth_size` int(11) NOT NULL,
  `lip_size` int(11) NOT NULL,
  `smile` int(11) NOT NULL,
  `lip_shape` int(11) NOT NULL,
  `jaw_height` int(11) NOT NULL,
  `chin_jut` int(11) NOT NULL,
  `ear_shape` int(11) NOT NULL,
  `head_size` int(11) NOT NULL,
  `neck` int(11) NOT NULL,
  `neck_length` int(11) NOT NULL,
  `shoulder_size` int(11) NOT NULL,
  `torso` int(11) NOT NULL,
  `chest` int(11) NOT NULL,
  `waist` int(11) NOT NULL,
  `hips` int(11) NOT NULL,
  `arm_thickness` int(11) NOT NULL,
  `hand_size` int(11) NOT NULL,
  `leg_thickness` int(11) NOT NULL,
  `facial_rate` int(11) NOT NULL,
  `foot_size` int(11) NOT NULL,
  `arm_length` int(11) NOT NULL,
  `leg_length` int(11) NOT NULL,
  `shoulders` int(11) NOT NULL,
  `face_shape` int(11) NOT NULL,
  `pupil_size` int(11) NOT NULL,
  `upper_torso` int(11) NOT NULL,
  `fore_arm_thickness` int(11) NOT NULL,
  `hand_span` int(11) NOT NULL,
  `calf_thickness` int(11) NOT NULL,
  `height` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_bind_point`
--

CREATE TABLE `player_bind_point` (
  `player_id` int(11) NOT NULL,
  `map_id` int(11) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `heading` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_cooldowns`
--

CREATE TABLE `player_cooldowns` (
  `player_id` int(11) NOT NULL,
  `cooldown_id` int(6) NOT NULL,
  `reuse_delay` bigint(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_cp`
--

CREATE TABLE `player_cp` (
  `player_id` int(11) NOT NULL,
  `slot` int(11) NOT NULL,
  `point` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_cubic`
--

CREATE TABLE `player_cubic` (
  `player_id` int(11) NOT NULL,
  `cubic_id` int(11) NOT NULL,
  `rank` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `stat_value` int(11) NOT NULL,
  `category` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Структура таблицы `player_effects`
--

CREATE TABLE `player_effects` (
  `player_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `skill_lvl` tinyint(4) NOT NULL,
  `current_time` int(11) NOT NULL,
  `end_time` bigint(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_emotions`
--

CREATE TABLE `player_emotions` (
  `player_id` int(11) NOT NULL,
  `emotion` int(11) NOT NULL,
  `remaining` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_equipment_setting`
--

CREATE TABLE `player_equipment_setting` (
  `player_id` int(11) NOT NULL,
  `slot` int(255) NOT NULL,
  `display` tinyint(2) NOT NULL DEFAULT '0',
  `m_hand` int(21) NOT NULL DEFAULT '0',
  `s_hand` int(21) NOT NULL DEFAULT '0',
  `helmet` int(21) NOT NULL DEFAULT '0',
  `torso` int(21) NOT NULL DEFAULT '0',
  `glove` int(21) NOT NULL DEFAULT '0',
  `boots` int(21) NOT NULL DEFAULT '0',
  `earrings_left` int(21) NOT NULL DEFAULT '0',
  `earrings_right` int(21) NOT NULL DEFAULT '0',
  `ring_left` int(21) NOT NULL DEFAULT '0',
  `ring_right` int(21) NOT NULL DEFAULT '0',
  `necklace` int(21) NOT NULL DEFAULT '0',
  `shoulder` int(21) NOT NULL DEFAULT '0',
  `pants` int(21) NOT NULL DEFAULT '0',
  `powershard_left` int(21) NOT NULL DEFAULT '0',
  `powershard_right` int(21) NOT NULL DEFAULT '0',
  `wings` int(21) NOT NULL DEFAULT '0',
  `waist` int(21) NOT NULL DEFAULT '0',
  `m_off_hand` int(21) NOT NULL DEFAULT '0',
  `s_off_hand` int(21) NOT NULL DEFAULT '0',
  `plume` int(21) NOT NULL DEFAULT '0',
  `bracelet` int(21) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_events_window`
--

CREATE TABLE `player_events_window` (
  `account_id` int(11) NOT NULL DEFAULT '0',
  `event_id` int(11) NOT NULL DEFAULT '0',
  `last_stamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `elapsed` int(11) NOT NULL DEFAULT '0',
  `reward_recived_count` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_game_stats`
--

CREATE TABLE `player_game_stats` (
  `player_id` int(11) NOT NULL,
  `defense_physic` int(11) NOT NULL DEFAULT '1',
  `block` int(11) NOT NULL DEFAULT '1',
  `parry` int(11) NOT NULL DEFAULT '1',
  `magical_critical` int(11) NOT NULL DEFAULT '1',
  `evasion` int(11) NOT NULL DEFAULT '1',
  `precision` int(11) NOT NULL DEFAULT '1',
  `attack` int(11) NOT NULL DEFAULT '1',
  `magical_precision` int(11) NOT NULL DEFAULT '1',
  `attack_speed` int(11) NOT NULL DEFAULT '1',
  `magical_resist` int(11) NOT NULL DEFAULT '1',
  `magical_attack` int(11) NOT NULL DEFAULT '1',
  `main_hand_magical_attack` int(11) NOT NULL DEFAULT '1',
  `off_hand_magical_attack` int(11) NOT NULL DEFAULT '1',
  `physical_critical` int(11) NOT NULL DEFAULT '1',
  `attack_range` int(11) NOT NULL DEFAULT '1',
  `magical_defense` int(11) NOT NULL DEFAULT '1',
  `agility` int(11) NOT NULL DEFAULT '1',
  `knowledge` int(11) NOT NULL DEFAULT '1',
  `will` int(11) NOT NULL DEFAULT '1',
  `magical_boost` int(11) NOT NULL DEFAULT '1',
  `magical_boost_resist` int(11) NOT NULL DEFAULT '1',
  `physical_critical_resist` int(11) NOT NULL DEFAULT '1',
  `magical_critical_resist` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_life_stats`
--

CREATE TABLE `player_life_stats` (
  `player_id` int(11) NOT NULL,
  `hp` int(11) NOT NULL DEFAULT '1',
  `mp` int(11) NOT NULL DEFAULT '1',
  `fp` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_luna_shop`
--

CREATE TABLE `player_luna_shop` (
  `player_id` int(10) NOT NULL,
  `free_under` tinyint(1) NOT NULL,
  `free_munition` tinyint(1) NOT NULL,
  `free_chest` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_macrosses`
--

CREATE TABLE `player_macrosses` (
  `player_id` int(11) NOT NULL,
  `order` int(3) NOT NULL,
  `macro` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_minions`
--

CREATE TABLE `player_minions` (
  `player_id` int(11) NOT NULL,
  `object_id` int(11) NOT NULL DEFAULT '0',
  `minion_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `grade` varchar(11) NOT NULL,
  `level` varchar(11) NOT NULL,
  `birthday` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `growthpoints` int(6) NOT NULL DEFAULT '0',
  `is_locked` int(1) NOT NULL DEFAULT '0',
  `buff_bag` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_monsterbook`
--

CREATE TABLE `player_monsterbook` (
  `player_id` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `kill_count` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `claim_reward` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_motions`
--

CREATE TABLE `player_motions` (
  `player_id` int(11) NOT NULL,
  `motion_id` int(3) NOT NULL,
  `time` int(11) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_npc_factions`
--

CREATE TABLE `player_npc_factions` (
  `player_id` int(11) NOT NULL,
  `faction_id` int(2) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `time` int(11) NOT NULL,
  `state` enum('NOTING','START','COMPLETE') NOT NULL DEFAULT 'NOTING',
  `quest_id` int(6) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_passkey`
--

CREATE TABLE `player_passkey` (
  `account_id` int(11) NOT NULL,
  `passkey` varchar(32) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_pets`
--

CREATE TABLE `player_pets` (
  `player_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `decoration` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `hungry_level` tinyint(4) NOT NULL DEFAULT '0',
  `feed_progress` int(11) NOT NULL DEFAULT '0',
  `reuse_time` bigint(20) NOT NULL DEFAULT '0',
  `birthday` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mood_started` bigint(20) NOT NULL DEFAULT '0',
  `counter` int(11) NOT NULL DEFAULT '0',
  `mood_cd_started` bigint(20) NOT NULL DEFAULT '0',
  `gift_cd_started` bigint(20) NOT NULL DEFAULT '0',
  `dopings` varchar(80) CHARACTER SET ascii DEFAULT NULL,
  `despawn_time` timestamp NULL DEFAULT NULL,
  `expire_time` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_punishments`
--

CREATE TABLE `player_punishments` (
  `player_id` int(11) NOT NULL,
  `punishment_type` enum('PRISON','GATHER','CHARBAN') NOT NULL,
  `start_time` int(10) UNSIGNED DEFAULT '0',
  `duration` int(10) UNSIGNED DEFAULT '0',
  `reason` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_quests`
--

CREATE TABLE `player_quests` (
  `player_id` int(11) NOT NULL,
  `quest_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `status` varchar(10) NOT NULL DEFAULT 'NONE',
  `quest_vars` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `complete_count` int(3) UNSIGNED NOT NULL DEFAULT '0',
  `next_repeat_time` timestamp NULL DEFAULT NULL,
  `reward` smallint(3) DEFAULT NULL,
  `complete_time` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_ranking`
--

CREATE TABLE `player_ranking` (
  `player_id` int(10) NOT NULL,
  `table_id` int(10) NOT NULL,
  `rank` int(10) NOT NULL DEFAULT '0',
  `last_rank` int(10) NOT NULL DEFAULT '0',
  `points` int(10) NOT NULL DEFAULT '0',
  `last_points` int(10) NOT NULL DEFAULT '0',
  `high_points` int(10) NOT NULL DEFAULT '0',
  `low_points` int(10) NOT NULL DEFAULT '0',
  `position_match` int(10) NOT NULL DEFAULT '5'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_recipes`
--

CREATE TABLE `player_recipes` (
  `player_id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_registered_items`
--

CREATE TABLE `player_registered_items` (
  `player_id` int(10) NOT NULL,
  `item_unique_id` int(10) NOT NULL,
  `item_id` int(10) NOT NULL,
  `expire_time` int(20) DEFAULT NULL,
  `color` int(11) DEFAULT NULL,
  `color_expires` int(11) NOT NULL DEFAULT '0',
  `owner_use_count` int(10) NOT NULL DEFAULT '0',
  `visitor_use_count` int(10) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `h` smallint(3) DEFAULT NULL,
  `area` enum('NONE','INTERIOR','EXTERIOR','ALL','DECOR') NOT NULL DEFAULT 'NONE',
  `floor` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_settings`
--

CREATE TABLE `player_settings` (
  `player_id` int(11) NOT NULL,
  `settings_type` tinyint(1) NOT NULL,
  `settings` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_shugo_sweep`
--

CREATE TABLE `player_shugo_sweep` (
  `player_id` int(11) NOT NULL,
  `free_dice` int(10) NOT NULL DEFAULT '0',
  `sweep_step` int(10) NOT NULL DEFAULT '0',
  `board_id` int(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_skills`
--

CREATE TABLE `player_skills` (
  `player_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `skill_level` int(3) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_skill_skins`
--

CREATE TABLE `player_skill_skins` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `skin_id` int(11) NOT NULL DEFAULT '0',
  `remaining` bigint(22) DEFAULT '0',
  `active` int(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_titles`
--

CREATE TABLE `player_titles` (
  `player_id` int(11) NOT NULL,
  `title_id` int(11) NOT NULL,
  `remaining` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_transformation`
--

CREATE TABLE `player_transformation` (
  `player_id` int(10) NOT NULL,
  `panel_id` int(5) NOT NULL DEFAULT '0',
  `item_id` int(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_vars`
--

CREATE TABLE `player_vars` (
  `player_id` int(11) NOT NULL,
  `param` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `time` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_wardrobe`
--

CREATE TABLE `player_wardrobe` (
  `player_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `slot` int(11) NOT NULL,
  `reskin_count` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `player_world_bans`
--

CREATE TABLE `player_world_bans` (
  `player` int(11) NOT NULL,
  `by` varchar(255) NOT NULL,
  `duration` bigint(11) NOT NULL,
  `date` bigint(11) NOT NULL,
  `reason` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `portal_cooldowns`
--

CREATE TABLE `portal_cooldowns` (
  `player_id` int(11) NOT NULL,
  `world_id` int(11) NOT NULL,
  `reuse_time` bigint(13) NOT NULL,
  `entry_count` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `server_variables`
--

CREATE TABLE `server_variables` (
  `key` varchar(30) NOT NULL,
  `value` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `server_variables`
--

INSERT INTO `server_variables` (`key`, `value`) VALUES
('auctionProlonged', '0'),
('auctionTime', '1745719500'),
('houseMaintainTime', '1745762400'),
('time', '2');

-- --------------------------------------------------------

--
-- Структура таблицы `siege_locations`
--

CREATE TABLE `siege_locations` (
  `id` int(11) NOT NULL,
  `race` enum('ELYOS','ASMODIANS','BALAUR') NOT NULL,
  `legion_id` int(11) NOT NULL,
  `occupy_count` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `siege_locations`
--

INSERT INTO `siege_locations` (`id`, `race`, `legion_id`, `occupy_count`) VALUES
(1011, 'BALAUR', 0, 1),
(1014, 'BALAUR', 0, 0),
(1016, 'BALAUR', 0, 0),
(1017, 'BALAUR', 0, 0),
(1018, 'BALAUR', 0, 0),
(1019, 'BALAUR', 0, 0),
(1511, 'BALAUR', 0, 0),
(1512, 'BALAUR', 0, 0),
(1513, 'BALAUR', 0, 0),
(1514, 'BALAUR', 0, 0),
(1515, 'BALAUR', 0, 0),
(1516, 'BALAUR', 0, 0),
(1517, 'BALAUR', 0, 0),
(1518, 'BALAUR', 0, 0),
(1519, 'BALAUR', 0, 0),
(1521, 'BALAUR', 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `siege_spawns`
--

CREATE TABLE `siege_spawns` (
  `spawn_id` int(10) NOT NULL,
  `siege_id` int(10) NOT NULL,
  `race` enum('ELYOS','ASMODIANS','BALAUR') NOT NULL,
  `protector` int(10) DEFAULT '0',
  `stype` enum('PEACE','GUARD','ARTIFACT','PROTECTOR','MINE','PORTAL','GENERATOR','SPRING','RACEPROTECTOR','UNDERPASS') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Структура таблицы `skill_motions`
--

CREATE TABLE `skill_motions` (
  `motion_name` varchar(255) NOT NULL DEFAULT '',
  `skill_id` int(11) NOT NULL,
  `attack_speed` int(11) NOT NULL,
  `weapon_type` varchar(255) NOT NULL,
  `off_weapon_type` varchar(255) NOT NULL,
  `time` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `spawns`
--

CREATE TABLE `spawns` (
  `spawn_id` int(10) NOT NULL,
  `npc_id` int(10) NOT NULL,
  `npc_name` varchar(50) NOT NULL DEFAULT '',
  `map_id` int(10) NOT NULL,
  `pool_size` int(5) NOT NULL DEFAULT '1',
  `anchor` varchar(100) DEFAULT NULL,
  `handler` enum('RIFT','STATIC') DEFAULT NULL,
  `spawn_time` enum('ALL','DAY','NIGHT') NOT NULL DEFAULT 'ALL',
  `walker_id` int(10) NOT NULL DEFAULT '0',
  `random_walk` int(10) NOT NULL DEFAULT '0',
  `static_id` int(10) NOT NULL DEFAULT '0',
  `fly` tinyint(1) NOT NULL DEFAULT '0',
  `respawn_time` int(10) NOT NULL DEFAULT '0',
  `last_despawn_time` timestamp NULL DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `author` varchar(50) NOT NULL DEFAULT 'system'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Структура таблицы `special_landing`
--

CREATE TABLE `special_landing` (
  `id` int(2) NOT NULL,
  `type` enum('SPAWN','DESPAWN') NOT NULL DEFAULT 'DESPAWN'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `surveys`
--

CREATE TABLE `surveys` (
  `unique_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_count` decimal(20,0) NOT NULL DEFAULT '1',
  `html_text` text NOT NULL,
  `html_radio` varchar(100) NOT NULL DEFAULT 'accept',
  `used` tinyint(1) NOT NULL DEFAULT '0',
  `used_time` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `tasks`
--

CREATE TABLE `tasks` (
  `id` int(5) NOT NULL,
  `task_type` enum('SHUTDOWN','RESTART') NOT NULL,
  `trigger_type` enum('FIXED_IN_TIME') NOT NULL,
  `trigger_param` text NOT NULL,
  `exec_param` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `towns`
--

CREATE TABLE `towns` (
  `id` int(11) NOT NULL,
  `level` int(11) NOT NULL DEFAULT '1',
  `points` int(10) NOT NULL DEFAULT '0',
  `race` enum('ELYOS','ASMODIANS') NOT NULL,
  `level_up_date` timestamp NOT NULL DEFAULT '1970-01-01 04:00:01'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `towns`
--

INSERT INTO `towns` (`id`, `level`, `points`, `race`, `level_up_date`) VALUES
(1001, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1002, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1003, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1004, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1005, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1006, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1007, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1008, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1009, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1010, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1011, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1012, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1013, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1014, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1015, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1016, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1017, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1018, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1019, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1020, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1021, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1022, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1023, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1024, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(1025, 1, 0, 'ELYOS', '1970-01-01 04:00:01'),
(2001, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2002, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2003, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2004, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2005, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2006, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2007, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2008, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2009, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2010, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2011, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2012, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2013, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2014, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2015, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2016, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2017, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2018, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2019, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2020, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2021, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2022, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2023, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2024, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01'),
(2025, 1, 0, 'ASMODIANS', '1970-01-01 04:00:01');

-- --------------------------------------------------------

--
-- Структура таблицы `transformations`
--

CREATE TABLE `transformations` (
  `player_id` int(11) NOT NULL,
  `transformation_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `grade` varchar(11) NOT NULL,
  `count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `web_reward`
--

CREATE TABLE `web_reward` (
  `unique` int(11) NOT NULL,
  `item_owner` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_count` decimal(20,0) NOT NULL DEFAULT '1',
  `rewarded` tinyint(1) NOT NULL DEFAULT '0',
  `added` varchar(70) DEFAULT '',
  `received` varchar(70) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `weddings`
--

CREATE TABLE `weddings` (
  `id` int(11) UNSIGNED NOT NULL,
  `player1` int(11) NOT NULL,
  `player2` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `abyss_rank`
--
ALTER TABLE `abyss_rank`
  ADD PRIMARY KEY (`player_id`);

--
-- Индексы таблицы `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `banned_hdd`
--
ALTER TABLE `banned_hdd`
  ADD PRIMARY KEY (`uniId`);

--
-- Индексы таблицы `base_location`
--
ALTER TABLE `base_location`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `blocks`
--
ALTER TABLE `blocks`
  ADD PRIMARY KEY (`player`,`blocked_player`),
  ADD KEY `blocked_player` (`blocked_player`);

--
-- Индексы таблицы `bookmark`
--
ALTER TABLE `bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `broker`
--
ALTER TABLE `broker`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seller_id` (`seller_id`);

--
-- Индексы таблицы `challenge_tasks`
--
ALTER TABLE `challenge_tasks`
  ADD PRIMARY KEY (`task_id`,`quest_id`,`owner_id`,`owner_type`);

--
-- Индексы таблицы `craft_cooldowns`
--
ALTER TABLE `craft_cooldowns`
  ADD PRIMARY KEY (`player_id`,`delay_id`);

--
-- Индексы таблицы `event_items`
--
ALTER TABLE `event_items`
  ADD PRIMARY KEY (`player_id`,`item_id`);

--
-- Индексы таблицы `f2paccount`
--
ALTER TABLE `f2paccount`
  ADD PRIMARY KEY (`account_id`);

--
-- Индексы таблицы `friends`
--
ALTER TABLE `friends`
  ADD PRIMARY KEY (`player`,`friend`),
  ADD KEY `friend` (`friend`);

--
-- Индексы таблицы `guides`
--
ALTER TABLE `guides`
  ADD PRIMARY KEY (`guide_id`),
  ADD KEY `player_id` (`player_id`);

--
-- Индексы таблицы `guild_quests`
--
ALTER TABLE `guild_quests`
  ADD PRIMARY KEY (`player_id`);

--
-- Индексы таблицы `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `address` (`address`) USING BTREE,
  ADD KEY `address_2` (`address`) USING BTREE;

--
-- Индексы таблицы `house_bids`
--
ALTER TABLE `house_bids`
  ADD PRIMARY KEY (`player_id`,`house_id`,`bid`),
  ADD KEY `house_id_ibfk_1` (`house_id`);

--
-- Индексы таблицы `house_object_cooldowns`
--
ALTER TABLE `house_object_cooldowns`
  ADD PRIMARY KEY (`player_id`,`object_id`);

--
-- Индексы таблицы `house_scripts`
--
ALTER TABLE `house_scripts`
  ADD PRIMARY KEY (`house_id`,`index`);

--
-- Индексы таблицы `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`item_unique_id`),
  ADD KEY `item_location` (`item_location`) USING HASH,
  ADD KEY `index3` (`item_owner`,`item_location`,`is_equiped`);

--
-- Индексы таблицы `item_cooldowns`
--
ALTER TABLE `item_cooldowns`
  ADD PRIMARY KEY (`player_id`,`delay_id`);

--
-- Индексы таблицы `item_stones`
--
ALTER TABLE `item_stones`
  ADD PRIMARY KEY (`item_unique_id`,`slot`,`category`);

--
-- Индексы таблицы `legions`
--
ALTER TABLE `legions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_unique` (`name`);

--
-- Индексы таблицы `legion_announcement_list`
--
ALTER TABLE `legion_announcement_list`
  ADD KEY `legion_id` (`legion_id`);

--
-- Индексы таблицы `legion_emblems`
--
ALTER TABLE `legion_emblems`
  ADD PRIMARY KEY (`legion_id`);

--
-- Индексы таблицы `legion_history`
--
ALTER TABLE `legion_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `legion_id` (`legion_id`);

--
-- Индексы таблицы `legion_join_requests`
--
ALTER TABLE `legion_join_requests`
  ADD PRIMARY KEY (`legionId`,`playerId`);

--
-- Индексы таблицы `legion_members`
--
ALTER TABLE `legion_members`
  ADD PRIMARY KEY (`player_id`),
  ADD KEY `player_id` (`player_id`),
  ADD KEY `legion_id` (`legion_id`);

--
-- Индексы таблицы `mail`
--
ALTER TABLE `mail`
  ADD PRIMARY KEY (`mail_unique_id`),
  ADD KEY `mail_recipient_id` (`mail_recipient_id`);

--
-- Индексы таблицы `network_ban`
--
ALTER TABLE `network_ban`
  ADD PRIMARY KEY (`uniId`);

--
-- Индексы таблицы `old_names`
--
ALTER TABLE `old_names`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `petitions`
--
ALTER TABLE `petitions`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_unique` (`name`),
  ADD KEY `account_id` (`account_id`);

--
-- Индексы таблицы `player_appearance`
--
ALTER TABLE `player_appearance`
  ADD PRIMARY KEY (`player_id`);

--
-- Индексы таблицы `player_bind_point`
--
ALTER TABLE `player_bind_point`
  ADD PRIMARY KEY (`player_id`);

--
-- Индексы таблицы `player_cooldowns`
--
ALTER TABLE `player_cooldowns`
  ADD PRIMARY KEY (`player_id`,`cooldown_id`);

--
-- Индексы таблицы `player_cp`
--
ALTER TABLE `player_cp`
  ADD PRIMARY KEY (`player_id`,`slot`);

--
-- Индексы таблицы `player_cubic`
--
ALTER TABLE `player_cubic`
  ADD PRIMARY KEY (`player_id`,`cubic_id`) USING BTREE;

--
-- Индексы таблицы `player_effects`
--
ALTER TABLE `player_effects`
  ADD PRIMARY KEY (`player_id`,`skill_id`);

--
-- Индексы таблицы `player_emotions`
--
ALTER TABLE `player_emotions`
  ADD PRIMARY KEY (`player_id`,`emotion`);

--
-- Индексы таблицы `player_equipment_setting`
--
ALTER TABLE `player_equipment_setting`
  ADD PRIMARY KEY (`player_id`,`slot`);

--
-- Индексы таблицы `player_events_window`
--
ALTER TABLE `player_events_window`
  ADD PRIMARY KEY (`account_id`,`event_id`);

--
-- Индексы таблицы `player_game_stats`
--
ALTER TABLE `player_game_stats`
  ADD PRIMARY KEY (`player_id`);

--
-- Индексы таблицы `player_life_stats`
--
ALTER TABLE `player_life_stats`
  ADD PRIMARY KEY (`player_id`);

--
-- Индексы таблицы `player_luna_shop`
--
ALTER TABLE `player_luna_shop`
  ADD PRIMARY KEY (`player_id`);

--
-- Индексы таблицы `player_macrosses`
--
ALTER TABLE `player_macrosses`
  ADD UNIQUE KEY `main` (`player_id`,`order`);

--
-- Индексы таблицы `player_minions`
--
ALTER TABLE `player_minions`
  ADD PRIMARY KEY (`player_id`,`object_id`);

--
-- Индексы таблицы `player_monsterbook`
--
ALTER TABLE `player_monsterbook`
  ADD PRIMARY KEY (`player_id`,`id`);

--
-- Индексы таблицы `player_motions`
--
ALTER TABLE `player_motions`
  ADD PRIMARY KEY (`player_id`,`motion_id`) USING BTREE;

--
-- Индексы таблицы `player_npc_factions`
--
ALTER TABLE `player_npc_factions`
  ADD PRIMARY KEY (`player_id`,`faction_id`);

--
-- Индексы таблицы `player_passkey`
--
ALTER TABLE `player_passkey`
  ADD PRIMARY KEY (`account_id`,`passkey`);

--
-- Индексы таблицы `player_pets`
--
ALTER TABLE `player_pets`
  ADD PRIMARY KEY (`player_id`,`pet_id`);

--
-- Индексы таблицы `player_punishments`
--
ALTER TABLE `player_punishments`
  ADD PRIMARY KEY (`player_id`,`punishment_type`);

--
-- Индексы таблицы `player_quests`
--
ALTER TABLE `player_quests`
  ADD PRIMARY KEY (`player_id`,`quest_id`);

--
-- Индексы таблицы `player_ranking`
--
ALTER TABLE `player_ranking`
  ADD PRIMARY KEY (`player_id`);

--
-- Индексы таблицы `player_recipes`
--
ALTER TABLE `player_recipes`
  ADD PRIMARY KEY (`player_id`,`recipe_id`);

--
-- Индексы таблицы `player_registered_items`
--
ALTER TABLE `player_registered_items`
  ADD PRIMARY KEY (`player_id`,`item_unique_id`,`item_id`);

--
-- Индексы таблицы `player_settings`
--
ALTER TABLE `player_settings`
  ADD PRIMARY KEY (`player_id`,`settings_type`);

--
-- Индексы таблицы `player_shugo_sweep`
--
ALTER TABLE `player_shugo_sweep`
  ADD PRIMARY KEY (`player_id`);

--
-- Индексы таблицы `player_skills`
--
ALTER TABLE `player_skills`
  ADD PRIMARY KEY (`player_id`,`skill_id`);

--
-- Индексы таблицы `player_skill_skins`
--
ALTER TABLE `player_skill_skins`
  ADD PRIMARY KEY (`player_id`,`skin_id`);

--
-- Индексы таблицы `player_titles`
--
ALTER TABLE `player_titles`
  ADD PRIMARY KEY (`player_id`,`title_id`);

--
-- Индексы таблицы `player_transformation`
--
ALTER TABLE `player_transformation`
  ADD PRIMARY KEY (`player_id`);

--
-- Индексы таблицы `player_vars`
--
ALTER TABLE `player_vars`
  ADD PRIMARY KEY (`player_id`,`param`);

--
-- Индексы таблицы `player_wardrobe`
--
ALTER TABLE `player_wardrobe`
  ADD PRIMARY KEY (`player_id`,`item_id`);

--
-- Индексы таблицы `player_world_bans`
--
ALTER TABLE `player_world_bans`
  ADD PRIMARY KEY (`player`);

--
-- Индексы таблицы `portal_cooldowns`
--
ALTER TABLE `portal_cooldowns`
  ADD PRIMARY KEY (`player_id`,`world_id`);

--
-- Индексы таблицы `server_variables`
--
ALTER TABLE `server_variables`
  ADD PRIMARY KEY (`key`);

--
-- Индексы таблицы `siege_locations`
--
ALTER TABLE `siege_locations`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `siege_spawns`
--
ALTER TABLE `siege_spawns`
  ADD PRIMARY KEY (`spawn_id`);

--
-- Индексы таблицы `skill_motions`
--
ALTER TABLE `skill_motions`
  ADD PRIMARY KEY (`motion_name`,`skill_id`,`attack_speed`,`weapon_type`,`off_weapon_type`);

--
-- Индексы таблицы `spawns`
--
ALTER TABLE `spawns`
  ADD PRIMARY KEY (`spawn_id`);

--
-- Индексы таблицы `surveys`
--
ALTER TABLE `surveys`
  ADD PRIMARY KEY (`unique_id`),
  ADD KEY `owner_id` (`owner_id`);

--
-- Индексы таблицы `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `towns`
--
ALTER TABLE `towns`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `transformations`
--
ALTER TABLE `transformations`
  ADD PRIMARY KEY (`player_id`,`transformation_id`);

--
-- Индексы таблицы `web_reward`
--
ALTER TABLE `web_reward`
  ADD PRIMARY KEY (`unique`),
  ADD KEY `item_owner` (`item_owner`);

--
-- Индексы таблицы `weddings`
--
ALTER TABLE `weddings`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `player1` (`player1`),
  ADD KEY `player2` (`player2`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `banned_hdd`
--
ALTER TABLE `banned_hdd`
  MODIFY `uniId` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `bookmark`
--
ALTER TABLE `bookmark`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `broker`
--
ALTER TABLE `broker`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `guides`
--
ALTER TABLE `guides`
  MODIFY `guide_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=329322;

--
-- AUTO_INCREMENT для таблицы `legion_history`
--
ALTER TABLE `legion_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT для таблицы `network_ban`
--
ALTER TABLE `network_ban`
  MODIFY `uniId` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `old_names`
--
ALTER TABLE `old_names`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `spawns`
--
ALTER TABLE `spawns`
  MODIFY `spawn_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `surveys`
--
ALTER TABLE `surveys`
  MODIFY `unique_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `web_reward`
--
ALTER TABLE `web_reward`
  MODIFY `unique` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `weddings`
--
ALTER TABLE `weddings`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `abyss_rank`
--
ALTER TABLE `abyss_rank`
  ADD CONSTRAINT `abyss_rank_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `blocks`
--
ALTER TABLE `blocks`
  ADD CONSTRAINT `blocks_ibfk_1` FOREIGN KEY (`player`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `blocks_ibfk_2` FOREIGN KEY (`blocked_player`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `broker`
--
ALTER TABLE `broker`
  ADD CONSTRAINT `broker_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `craft_cooldowns`
--
ALTER TABLE `craft_cooldowns`
  ADD CONSTRAINT `craft_cooldowns_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `event_items`
--
ALTER TABLE `event_items`
  ADD CONSTRAINT `event_items_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `friends`
--
ALTER TABLE `friends`
  ADD CONSTRAINT `friends_ibfk_1` FOREIGN KEY (`player`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `friends_ibfk_2` FOREIGN KEY (`friend`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `guides`
--
ALTER TABLE `guides`
  ADD CONSTRAINT `guides_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `guild_quests`
--
ALTER TABLE `guild_quests`
  ADD CONSTRAINT `guild_quests_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `house_bids`
--
ALTER TABLE `house_bids`
  ADD CONSTRAINT `house_id_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `house_scripts`
--
ALTER TABLE `house_scripts`
  ADD CONSTRAINT `houses_id_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `item_cooldowns`
--
ALTER TABLE `item_cooldowns`
  ADD CONSTRAINT `item_cooldowns_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `item_stones`
--
ALTER TABLE `item_stones`
  ADD CONSTRAINT `item_stones_ibfk_1` FOREIGN KEY (`item_unique_id`) REFERENCES `inventory` (`item_unique_id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `legion_announcement_list`
--
ALTER TABLE `legion_announcement_list`
  ADD CONSTRAINT `legion_announcement_list_ibfk_1` FOREIGN KEY (`legion_id`) REFERENCES `legions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `legion_emblems`
--
ALTER TABLE `legion_emblems`
  ADD CONSTRAINT `legion_emblems_ibfk_1` FOREIGN KEY (`legion_id`) REFERENCES `legions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `legion_history`
--
ALTER TABLE `legion_history`
  ADD CONSTRAINT `legion_history_ibfk_1` FOREIGN KEY (`legion_id`) REFERENCES `legions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `legion_members`
--
ALTER TABLE `legion_members`
  ADD CONSTRAINT `legion_members_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `legion_members_ibfk_2` FOREIGN KEY (`legion_id`) REFERENCES `legions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `mail`
--
ALTER TABLE `mail`
  ADD CONSTRAINT `FK_mail` FOREIGN KEY (`mail_recipient_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_appearance`
--
ALTER TABLE `player_appearance`
  ADD CONSTRAINT `player_id_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_bind_point`
--
ALTER TABLE `player_bind_point`
  ADD CONSTRAINT `player_bind_point_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_cooldowns`
--
ALTER TABLE `player_cooldowns`
  ADD CONSTRAINT `player_cooldowns_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_cp`
--
ALTER TABLE `player_cp`
  ADD CONSTRAINT `player_cp_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_cubic`
--
ALTER TABLE `player_cubic`
  ADD CONSTRAINT `fk_player_cubic` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_effects`
--
ALTER TABLE `player_effects`
  ADD CONSTRAINT `player_effects_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_emotions`
--
ALTER TABLE `player_emotions`
  ADD CONSTRAINT `player_emotions_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_game_stats`
--
ALTER TABLE `player_game_stats`
  ADD CONSTRAINT `player_game_stats` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_life_stats`
--
ALTER TABLE `player_life_stats`
  ADD CONSTRAINT `FK_player_life_stats` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_macrosses`
--
ALTER TABLE `player_macrosses`
  ADD CONSTRAINT `player_macrosses_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_monsterbook`
--
ALTER TABLE `player_monsterbook`
  ADD CONSTRAINT `fk_player_monsterbook` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_motions`
--
ALTER TABLE `player_motions`
  ADD CONSTRAINT `motions_player_id_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_npc_factions`
--
ALTER TABLE `player_npc_factions`
  ADD CONSTRAINT `player_npc_factions_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_pets`
--
ALTER TABLE `player_pets`
  ADD CONSTRAINT `FK_player_pets` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_punishments`
--
ALTER TABLE `player_punishments`
  ADD CONSTRAINT `player_punishments_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_quests`
--
ALTER TABLE `player_quests`
  ADD CONSTRAINT `player_quests_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_recipes`
--
ALTER TABLE `player_recipes`
  ADD CONSTRAINT `player_recipes_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_registered_items`
--
ALTER TABLE `player_registered_items`
  ADD CONSTRAINT `player_regitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_settings`
--
ALTER TABLE `player_settings`
  ADD CONSTRAINT `ps_pl_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_skills`
--
ALTER TABLE `player_skills`
  ADD CONSTRAINT `player_skills_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_titles`
--
ALTER TABLE `player_titles`
  ADD CONSTRAINT `player_titles_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_vars`
--
ALTER TABLE `player_vars`
  ADD CONSTRAINT `player_vars_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `player_wardrobe`
--
ALTER TABLE `player_wardrobe`
  ADD CONSTRAINT `player_wardrobe_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `portal_cooldowns`
--
ALTER TABLE `portal_cooldowns`
  ADD CONSTRAINT `portal_cooldowns_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `surveys`
--
ALTER TABLE `surveys`
  ADD CONSTRAINT `surveys_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `web_reward`
--
ALTER TABLE `web_reward`
  ADD CONSTRAINT `web_reward_ibfk_1` FOREIGN KEY (`item_owner`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `weddings`
--
ALTER TABLE `weddings`
  ADD CONSTRAINT `weddings_ibfk_1` FOREIGN KEY (`player1`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `weddings_ibfk_2` FOREIGN KEY (`player2`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
