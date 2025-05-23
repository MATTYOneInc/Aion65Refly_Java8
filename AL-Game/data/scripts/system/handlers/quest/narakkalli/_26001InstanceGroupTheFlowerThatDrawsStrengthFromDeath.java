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
package quest.narakkalli;

import com.aionemu.gameserver.model.DialogAction;
import com.aionemu.gameserver.model.gameobjects.player.Player;
import com.aionemu.gameserver.questEngine.handlers.QuestHandler;
import com.aionemu.gameserver.questEngine.model.QuestEnv;
import com.aionemu.gameserver.questEngine.model.QuestState;
import com.aionemu.gameserver.questEngine.model.QuestStatus;

/**
 * @author QuestGenerator by Mariella
 */
public class _26001InstanceGroupTheFlowerThatDrawsStrengthFromDeath extends QuestHandler {

	private final static int questId = 26001;
	private final static int[] mobs = { 654173, 654018, 654019, 654020, 654021 };

	public _26001InstanceGroupTheFlowerThatDrawsStrengthFromDeath() {
		super(questId);
	}

	@Override
	public void register() {
		qe.registerQuestNpc(806594).addOnQuestStart(questId); // Cautious Bastikan
		qe.registerQuestNpc(806594).addOnTalkEvent(questId); // Cautious Bastikan
		qe.registerQuestNpc(731788).addOnQuestStart(questId); // Immobile Asmodian Daeva
		qe.registerQuestNpc(731788).addOnTalkEvent(questId); // Immobile Asmodian Daeva
		qe.registerQuestNpc(731789).addOnQuestStart(questId); // Dying Asmodian Daeva
		qe.registerQuestNpc(731789).addOnTalkEvent(questId); // Dying Asmodian Daeva
		qe.registerQuestNpc(731790).addOnQuestStart(questId); // Suffering Asmodian Daeva
		qe.registerQuestNpc(731790).addOnTalkEvent(questId); // Suffering Asmodian Daeva
		qe.registerQuestNpc(806598).addOnQuestStart(questId); // Sorrowful Bastikan
		qe.registerQuestNpc(806598).addOnTalkEvent(questId); // Sorrowful Bastikan
		qe.registerQuestNpc(836554).addOnQuestStart(questId); // Harun
		qe.registerQuestNpc(836554).addOnTalkEvent(questId); // Harun

		for (int mob : mobs) {
			qe.registerQuestNpc(mob).addOnKillEvent(questId);
		}
	}

	@Override
	public boolean onLvlUpEvent(QuestEnv env) {
		return defaultOnLvlUpEvent(env, 26000, false);
	}

	@Override
	public boolean onDialogEvent(QuestEnv env) {
		Player player = env.getPlayer();
		QuestState qs = player.getQuestStateList().getQuestState(questId);
		DialogAction dialog = env.getDialog();
		int targetId = env.getTargetId();

		if (qs == null || qs.getStatus() == QuestStatus.NONE ) {
	  		if (targetId == 806594) {
				switch (dialog) {
					case QUEST_SELECT: {
						return sendQuestDialog(env, 4762);
					}
					case QUEST_ACCEPT_1:
					case QUEST_ACCEPT_SIMPLE: {
						return sendQuestStartDialog(env);
					}
					case QUEST_REFUSE_SIMPLE: {
						return closeDialogWindow(env);
					}
					default:
						break;
				}
			}
		}
		else if (qs.getStatus() == QuestStatus.START) {
			switch (targetId) {
				case 806594: {
					switch (dialog) {
						case QUEST_SELECT: {
							return sendQuestDialog(env, 1011);
						}
						case SETPRO1: {
							qs.setQuestVar(1);
							updateQuestStatus(env);
							return closeDialogWindow(env);
						}
						case FINISH_DIALOG: {
							return sendQuestSelectionDialog(env);
						}
						default: 
							break;
					}
					break;
				}
				case 731788: {
					switch (dialog) {
						case QUEST_SELECT: {
							return sendQuestDialog(env, 1352);
						}
						case SETPRO2: {
							qs.setQuestVar(2);
							updateQuestStatus(env);
							return closeDialogWindow(env);
						}
						default: 
							break;
					}
					break;
				}
				case 731789: {
					switch (dialog) {
						case QUEST_SELECT: {
							return sendQuestDialog(env, 1693);
						}
						case SETPRO3: {
							qs.setQuestVar(3);
							updateQuestStatus(env);
							return closeDialogWindow(env);
						}
						default: 
							break;
					}
					break;
				}
				case 731790: {
					switch (dialog) {
						case QUEST_SELECT: {
							return sendQuestDialog(env, 2034);
						}
						case SETPRO4: {
							qs.setQuestVar(4);
							updateQuestStatus(env);
							return closeDialogWindow(env);
						}
						default: 
							break;
					}
					break;
				}
				case 806598: {
					switch (dialog) {
						case QUEST_SELECT: {
							return sendQuestDialog(env, 3739);
						}
						case SET_SUCCEED: {
							qs.setQuestVar(9);
							qs.setStatus(QuestStatus.REWARD);
							updateQuestStatus(env);
							return closeDialogWindow(env);
						}
						default: 
							break;
					}
					break;
				}
				default:
					break;
			}
		} else if (qs.getStatus() == QuestStatus.REWARD) {
			if (targetId == 836554) {
				return sendQuestEndDialog(env);
			}
		}

		return false;
	}
	/*
	@Override
	public boolean onKillEvent(QuestEnv env) {
		Player player = env.getPlayer();
		QuestState qs = player.getQuestStateList().getQuestState(questId);

		if (qs != null && qs.getStatus() == QuestStatus.START) {
			int var = qs.getQuestVarById(0);
			int var1 = qs.getQuestVarById(1);

			// (0) Step: 5, Count: 5, Mobs : 654173
			// (1) Step: 6, Count: 1, Mobs : 654018
			// (2) Step: 6, Count: 1, Mobs : 654019
			// (3) Step: 6, Count: 1, Mobs : 654020
			// (4) Step: 6, Count: 1, Mobs : 654021

			switch (var) {
				case 5: {
				// ???
				}
				case 6: {
					return defaultOnKillEvent(env, 654018, 6, 7, 0);
				}
				case 6: {
					return defaultOnKillEvent(env, 654019, 6, 7, 0);
				}
				case 6: {
					return defaultOnKillEvent(env, 654020, 6, 7, 0);
				}
				case 6: {
					qs.setQuestVar(7);
					qs.setStatus(QuestStatus.REWARD);
					updateQuestStatus(env);
					return true;
				}
				default:
					break;
			}
			return false;
		}
		return false;
	}
	*/
}
