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
package quest.vengar;

import com.aionemu.gameserver.model.DialogAction;
import com.aionemu.gameserver.model.gameobjects.player.Player;
import com.aionemu.gameserver.questEngine.handlers.QuestHandler;
import com.aionemu.gameserver.questEngine.model.QuestEnv;
import com.aionemu.gameserver.questEngine.model.QuestState;
import com.aionemu.gameserver.questEngine.model.QuestStatus;

/**
 * @author QuestGenerator by Mariella
 */
public class _72223UndeadDrakan extends QuestHandler {

	private final static int questId = 72223;

	public _72223UndeadDrakan() {
		super(questId);
	}

	@Override
	public void register() {
		qe.registerQuestNpc(804729).addOnQuestStart(questId); // Egzen
		qe.registerQuestNpc(804729).addOnTalkEvent(questId); // Egzen
		qe.registerQuestNpc(804913).addOnQuestStart(questId); // Redalf
		qe.registerQuestNpc(804913).addOnTalkEvent(questId); // Redalf
		qe.registerQuestNpc(804728).addOnQuestStart(questId); // Engrid
		qe.registerQuestNpc(804728).addOnTalkEvent(questId); // Engrid
		qe.registerQuestNpc(804911).addOnQuestStart(questId); // Zigmuel
		qe.registerQuestNpc(804911).addOnTalkEvent(questId); // Zigmuel
	}

	@Override
	public boolean onLvlUpEvent(QuestEnv env) {
		return defaultOnLvlUpEvent(env, 70200, false);
	}

	@Override
	public boolean onDialogEvent(QuestEnv env) {
		Player player = env.getPlayer();
		QuestState qs = player.getQuestStateList().getQuestState(questId);
		DialogAction dialog = env.getDialog();
		int targetId = env.getTargetId();

		if (qs == null || qs.getStatus() == QuestStatus.NONE ) {
	  		if (targetId == 804729) {
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
				case 804729: {
					switch (dialog) {
						case QUEST_SELECT: {
							return sendQuestDialog(env, 1011);
						}
						case CHECK_USER_HAS_QUEST_ITEM: {
							return checkQuestItems(env, 0, 0, true, 5, 2716);
						}
						case FINISH_DIALOG: {
							return sendQuestSelectionDialog(env);
						}
//						case QUEST_SELECT: {
//							if var==0
//								return sendQuestDialog(env, 1352);
//							else
//								return sendQuestDialog(env, 1693);
//						}
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
				case 804913: {
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
				case 804728: {
					switch (dialog) {
						case QUEST_SELECT: {
							return sendQuestDialog(env, 2034);
						}
						case SET_SUCCEED: {
							qs.setQuestVar(4);
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
			if (targetId == 804911) {
				return sendQuestEndDialog(env);
			}
		}

		return false;
	}
}
