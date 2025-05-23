/**
 * This file is part of Aion-Lightning <aion-lightning.org>.
 *
 *  Aion-Lightning is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  Aion-Lightning is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details. *
 *  You should have received a copy of the GNU General Public License
 *  along with Aion-Lightning.
 *  If not, see <http://www.gnu.org/licenses/>.
 */
package com.aionemu.gameserver.model.templates.item.actions;

import java.util.Iterator;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlType;

import com.aionemu.gameserver.configs.main.CustomConfig;
import com.aionemu.gameserver.configs.main.EnchantsConfig;
import com.aionemu.gameserver.controllers.observer.ItemUseObserver;
import com.aionemu.gameserver.model.DescriptionId;
import com.aionemu.gameserver.model.TaskId;
import com.aionemu.gameserver.model.gameobjects.Item;
import com.aionemu.gameserver.model.gameobjects.player.Player;
import com.aionemu.gameserver.model.templates.item.ArmorType;
import com.aionemu.gameserver.model.templates.item.ItemCategory;
import com.aionemu.gameserver.model.templates.item.ItemTemplate;
import com.aionemu.gameserver.network.aion.serverpackets.SM_ITEM_USAGE_ANIMATION;
import com.aionemu.gameserver.network.aion.serverpackets.SM_SYSTEM_MESSAGE;
import com.aionemu.gameserver.services.EnchantService;
import com.aionemu.gameserver.utils.PacketSendUtility;
import com.aionemu.gameserver.utils.ThreadPoolManager;
import com.aionemu.gameserver.world.World;

/**
 * @author Nemiroff, Wakizashi, vlog
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "EnchantItemAction")
public class EnchantItemAction extends AbstractItemAction {

	// Count of required supplements
	@XmlAttribute(name = "count")
	private int count;
	// Min level of enchantable item
	@XmlAttribute(name = "min_level")
	private Integer min_level;
	// Max level of enchantable item
	@XmlAttribute(name = "max_level")
	private Integer max_level;
	@XmlAttribute(name = "manastone_only")
	private boolean manastone_only;
	@XmlAttribute(name = "chance")
	private float chance;

	@Override
	public boolean canAct(Player player, Item parentItem, Item targetItem) {
		int EnchantKinah = EnchantService.EnchantKinah(targetItem);

		if (isSupplementAction()) {
			return false;
		}
		if (targetItem == null || parentItem == null) { // no item selected.
			PacketSendUtility.sendPacket(player, SM_SYSTEM_MESSAGE.STR_ITEM_COLOR_ERROR);
			return false;
		}
		if (targetItem.isEquipped() && targetItem.getItemTemplate().getCategory() == ItemCategory.STIGMA) {
			PacketSendUtility.sendPacket(player, SM_SYSTEM_MESSAGE.STR_MSG_CANT_ENCHANT_EQUIPED);
			return false;
		} 
		if (targetItem.isAmplified() && parentItem.getItemTemplate().isEnchantmentStone() && player.getInventory().getKinah() < EnchantKinah) {
			PacketSendUtility.sendPacket(player, SM_SYSTEM_MESSAGE.STR_MSG_NOT_ENOUGH_MONEY);
			return false;
		}
		
		if ((targetItem.canAmplify()) && parentItem.getItemTemplate().isEnchantmentStone() && targetItem.getEnchantOrAuthorizeLevel() == targetItem.getItemTemplate().getMaxEnchantLevel() && !targetItem.isAmplified()) {
			PacketSendUtility.sendPacket(player, SM_SYSTEM_MESSAGE.STR_MSG_EXCEED_ENCHANT_CANNOT_01(new DescriptionId(targetItem.getNameId())));
			return false;
		}
		return true;
	}

	@Override
	public void act(final Player player, final Item parentItem, final Item targetItem) {
		act(player, parentItem, targetItem, null, 1);
	}

	// necessary overloading to not change AbstractItemAction
	public void act(final Player player, final Item parentItem, final Item targetItem, final Item supplementItem, final int targetWeapon) {

		if (supplementItem != null && !checkSupplementLevel(player, supplementItem.getItemTemplate(), targetItem.getItemTemplate())) {
			return;
		}
		// Current enchant level
		final int currentEnchant = targetItem.getEnchantOrAuthorizeLevel();
		final boolean isSuccess = isSuccess(player, parentItem, targetItem, supplementItem, targetWeapon);
		switch (targetItem.getItemTemplate().getItemQuality()) {
			case ANCIENT:
			case RELIC:
			case FINALITY:
				if (currentEnchant == targetItem.getItemTemplate().getMaxAuthorize()) {
					//You cannot enchant %0 any further.
					PacketSendUtility.sendPacket(player, SM_SYSTEM_MESSAGE.STR_ENCHANT_ITEM_IT_CAN_NOT_BE_ENCHANTED_MORE_TIME(targetItem.getNameId()));
					return;
				}
				break;
			default:
				if (targetItem.getItemTemplate().getArmorType() != ArmorType.WING && !targetItem.getItemTemplate().getExceedEnchant() && targetItem.getEnchantOrAuthorizeLevel() == 10 && parentItem.getItemTemplate().getTemplateId() / 1000000 == 166 ) {
					// You cannot enchant %0 any further.
					PacketSendUtility.sendPacket(player, SM_SYSTEM_MESSAGE.STR_ENCHANT_ITEM_IT_CAN_NOT_BE_ENCHANTED_MORE_TIME(targetItem.getNameId()));
					return;
				}
				break;
		}
		PacketSendUtility.broadcastPacketAndReceive(player, new SM_ITEM_USAGE_ANIMATION(player.getObjectId(), targetItem.getObjectId(), parentItem.getObjectId(), parentItem.getItemTemplate().getTemplateId(), EnchantsConfig.ENCHANT_CAST_DELAY, 0));

		final ItemUseObserver observer = new ItemUseObserver() {

			@Override
			public void abort() {
				player.getController().cancelTask(TaskId.ITEM_USE);
				player.removeItemCoolDown(parentItem.getItemTemplate().getUseLimits().getDelayId());
				PacketSendUtility.sendPacket(player, new SM_SYSTEM_MESSAGE(1300457, new DescriptionId(targetItem.getNameId()))); // Enchant Item canceled
				PacketSendUtility.broadcastPacketAndReceive(player, new SM_ITEM_USAGE_ANIMATION(player.getObjectId(), targetItem.getObjectId(), parentItem.getObjectId(), parentItem.getItemTemplate().getTemplateId(), 0, 2));
				player.getObserveController().removeObserver(this);
			}
		};
		player.getObserveController().attach(observer);

		player.getController().addTask(TaskId.ITEM_USE, ThreadPoolManager.getInstance().schedule(new Runnable() {

			@Override
			public void run() {
				player.getObserveController().removeObserver(observer);
				// Enchantment stone
				switch (parentItem.getItemTemplate().getCategory()) {
					case ENCHANTMENT:
					case AMPLIFICATION: {
						if (targetItem.getItemTemplate().getCategory() == ItemCategory.STIGMA) {
							EnchantService.enchantStigmaAct(player, parentItem, targetItem, currentEnchant, isSuccess);
						} else { // Item
							EnchantService.enchantItemAct(player, parentItem, targetItem, currentEnchant, isSuccess);
						}
						break;
					}
					case STIGMA: {
						if (parentItem.getItemTemplate().getCategory() == targetItem.getItemTemplate().getCategory()) {
							EnchantService.enchantStigmaAct(player, parentItem, targetItem, currentEnchant, isSuccess);
						}
						break;
					}
					default:
						EnchantService.socketManastoneAct(player, parentItem, targetItem, targetWeapon, isSuccess);
						break;
				}
				if (CustomConfig.ENABLE_ENCHANT_ANNOUNCE) {
					switch (parentItem.getItemTemplate().getCategory()) {
						case ENCHANTMENT:
						case AMPLIFICATION: {
							Iterator<Player> iter = World.getInstance().getPlayersIterator();
							while (iter.hasNext()) {
								Player player2 = iter.next();
								switch (targetItem.getEnchantOrAuthorizeLevel()) {
									case 15: {
										if (player2.getRace() == player.getRace() && isSuccess) {
											PacketSendUtility.sendPacket(player2, SM_SYSTEM_MESSAGE.STR_MSG_ENCHANT_ITEM_SUCCEEDED_15(player.getName(), targetItem.getItemTemplate().getNameId()));	
										}
										break;
									}
									case 20: {
										if (player2.getRace() == player.getRace() && isSuccess) {
											PacketSendUtility.sendPacket(player2, SM_SYSTEM_MESSAGE.STR_MSG_ENCHANT_ITEM_SUCCEEDED_20(player.getName(), targetItem.getItemTemplate().getNameId()));	
										}
										break;
									}
									default:
										break;
								}
							}
						}
						default:
							break;
					}
				}
				PacketSendUtility.broadcastPacketAndReceive(player, new SM_ITEM_USAGE_ANIMATION(player.getObjectId(), 0, parentItem.getObjectId(), parentItem.getItemTemplate().getTemplateId(), 0, isSuccess ? 1 : 2));
			}
		}, EnchantsConfig.ENCHANT_CAST_DELAY));
	}

	/**
	 * Check, if the item enchant will be successful
	 *
	 * @param player
	 * @param parentItem
	 *            the enchantment-/manastone to insert
	 * @param targetItem
	 *            the current item to enchant
	 * @param supplementItem
	 *            the item to increase the enchant chance (if exists)
	 * @param targetWeapon
	 *            the fused weapon (if exists)
	 * @param currentEnchant
	 *            current enchant level
	 * @return true if successful
	 */
	private boolean isSuccess(final Player player, final Item parentItem, final Item targetItem, final Item supplementItem, final int targetWeapon) {
		if (parentItem.getItemTemplate() != null) {
			switch (parentItem.getItemTemplate().getCategory()) {
				case ENCHANTMENT:
				case AMPLIFICATION:
				case STIGMA: {
					return EnchantService.enchantItem(player, parentItem, targetItem, supplementItem);
				}
				default:
					return EnchantService.socketManastone(player, parentItem, targetItem, supplementItem, targetWeapon);
			}
		}
		return false;
	}

	public int getCount() {
		return count;
	}

	private int getMaxLevel() {
		return max_level != null ? max_level : 0;
	}

	private int getMinLevel() {
		return min_level != null ? min_level : 0;
	}

	public boolean isManastoneOnly() {
		return manastone_only;
	}

	public float getChance() {
		return chance;
	}

	private boolean isSupplementAction() {
		return getMinLevel() > 0 || getMaxLevel() > 0 || getChance() > 0 || isManastoneOnly();
	}

	private boolean checkSupplementLevel(final Player player, final ItemTemplate supplementTemplate, final ItemTemplate targetItemTemplate) {
		// Is item manastone? True - check if player can use supplement
		if (supplementTemplate.getCategory() != ItemCategory.ENCHANTMENT) {
			// Check if max item level is ok for the enchant
			int minEnchantLevel = targetItemTemplate.getLevel();
			int maxEnchantLevel = targetItemTemplate.getLevel();

			EnchantItemAction action = supplementTemplate.getActions().getEnchantAction();
			if (action != null) {
				if (action.getMinLevel() != 0) {
					minEnchantLevel = action.getMinLevel();
				}
				if (action.getMaxLevel() != 0) {
					maxEnchantLevel = action.getMaxLevel();
				}
			}

			if (minEnchantLevel <= targetItemTemplate.getLevel() && maxEnchantLevel >= targetItemTemplate.getLevel()) {
				return true;
			}

			PacketSendUtility.sendPacket(player, SM_SYSTEM_MESSAGE.STR_ITEM_ENCHANT_ASSISTANT_NO_RIGHT_ITEM);
			return false;
		}
		return true;
	}
}
