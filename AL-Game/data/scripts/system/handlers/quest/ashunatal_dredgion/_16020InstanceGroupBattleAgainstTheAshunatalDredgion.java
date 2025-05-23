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
package quest.ashunatal_dredgion;

import com.aionemu.gameserver.model.DialogAction;
import com.aionemu.gameserver.model.gameobjects.player.Player;
import com.aionemu.gameserver.questEngine.handlers.QuestHandler;
import com.aionemu.gameserver.questEngine.model.QuestEnv;
import com.aionemu.gameserver.questEngine.model.QuestState;
import com.aionemu.gameserver.questEngine.model.QuestStatus;

/**
 * @author QuestGenerator by Mariella
 */
public class _16020InstanceGroupBattleAgainstTheAshunatalDredgion extends QuestHandler {

	private final static int questId = 16020;
	private final static int[] mobs = { 654793, 654806, 654807, 654808, 654809, 654823 };

	public _16020InstanceGroupBattleAgainstTheAshunatalDredgion() {
		super(questId);
	}

	@Override
	public void register() {
		qe.registerQuestNpc(806259).addOnQuestStart(questId); // Nizna
		qe.registerQuestNpc(806259).addOnTalkEvent(questId); // Nizna
		qe.registerQuestNpc(806846).addOnQuestStart(questId); // Shamichael
		qe.registerQuestNpc(806846).addOnTalkEvent(questId); // Shamichael

		for (int mob : mobs) {
			qe.registerQuestNpc(mob).addOnKillEvent(questId);
		}
	}

	@Override
	public boolean onLvlUpEvent(QuestEnv env) {
		return defaultOnLvlUpEvent(env, 1000, true);
	}

	@Override
	public boolean onDialogEvent(QuestEnv env) {
		Player player = env.getPlayer();
		QuestState qs = player.getQuestStateList().getQuestState(questId);
		DialogAction dialog = env.getDialog();
		int targetId = env.getTargetId();

		if (qs == null || qs.getStatus() == QuestStatus.NONE ) {
	  		if (targetId == 806259) {
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
				case 806259: {
					switch (dialog) {
//						case QUEST_SELECT: {
//							return sendQuestDialog(env, 1352);
//						}
						case SETPRO2: {
							qs.setQuestVar(2);
							updateQuestStatus(env);
							return closeDialogWindow(env);
						}
//						case QUEST_SELECT: {
//							return sendQuestDialog(env, 1011);
//						}
						case FINISH_DIALOG: {
							return sendQuestSelectionDialog(env);
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
			if (targetId == 806846) {
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

			// (0) Step: 2, Count: 1, Mobs : 654793
			// (1) Step: 2, Count: 1, Mobs : 654806, 654807
			// (2) Step: 2, Count: 1, Mobs : 654808, 654809
			// (3) Step: 3, Count: 1, Mobs : 654823

			switch (var) {
				case 2: {
					return defaultOnKillEvent(env, 654793, 2, 3, 0);
				}
				case 2: {
					return defaultOnKillEvent(env, 654806, 654807, 2, 3, 0);
				}
				case 2: {
					return defaultOnKillEvent(env, 654808, 654809, 2, 3, 0);
				}
				case 3: {
					qs.setQuestVar(4);
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
