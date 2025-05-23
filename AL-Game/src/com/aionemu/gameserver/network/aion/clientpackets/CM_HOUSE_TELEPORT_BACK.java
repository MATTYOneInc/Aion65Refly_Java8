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
package com.aionemu.gameserver.network.aion.clientpackets;

import com.aionemu.gameserver.model.TeleportAnimation;
import com.aionemu.gameserver.model.gameobjects.player.Player;
import com.aionemu.gameserver.network.aion.AionClientPacket;
import com.aionemu.gameserver.network.aion.AionConnection.State;
import com.aionemu.gameserver.services.teleport.TeleportService2;

/**
 * @author Rolandas
 */
public class CM_HOUSE_TELEPORT_BACK extends AionClientPacket {

	public CM_HOUSE_TELEPORT_BACK(int opcode, State state, State... restStates) {
		super(opcode, state, restStates);
	}

	@Override
	protected void readImpl() {
		// Nothing to read
	}

	@Override
	protected void runImpl() {
		Player player = getConnection().getActivePlayer();
		float[] coords = player.getBattleReturnCoords();
		if (coords != null && player.getBattleReturnMap() != 0) {
			TeleportService2.teleportTo(player, player.getBattleReturnMap(), 1, coords[0], coords[1], coords[2], (byte) 0, TeleportAnimation.BEAM_ANIMATION);

			player.setBattleReturnCoords(0, null);
		}
	}
}
