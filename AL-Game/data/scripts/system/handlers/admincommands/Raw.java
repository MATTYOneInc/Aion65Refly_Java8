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
package admincommands;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.aionemu.gameserver.model.gameobjects.player.Player;
import com.aionemu.gameserver.network.aion.serverpackets.SM_CUSTOM_PACKET;
import com.aionemu.gameserver.network.aion.serverpackets.SM_CUSTOM_PACKET.PacketElementType;
import com.aionemu.gameserver.utils.PacketSendUtility;
import com.aionemu.gameserver.utils.chathandlers.AdminCommand;

/**
 * Send packet in raw format.
 *
 * @author Luno
 * @author Aquanox
 * @rework MATTY
 */
public class Raw extends AdminCommand {

    private static final File ROOT = new File("data/packets/");
    private static final Logger logger = LoggerFactory.getLogger(Raw.class);

    public Raw() {
        super("raw");
    }

    @Override
    public void execute(Player admin, String... params) {
        if (params.length != 1) {
            sendUsage(admin);
            return;
        }

        File file = new File(ROOT, params[0] + ".txt");

        if (!file.exists() || !file.canRead()) {
            PacketSendUtility.sendMessage(admin, "Wrong file selected.");
            return;
        }

        try {
            List<String> lines = Files.readAllLines(file.toPath());
            PacketSendUtility.sendMessage(admin, "lines " + lines.size());

            Optional<SM_CUSTOM_PACKET> packet = processLines(lines);
            
            packet.ifPresent(p -> {
                PacketSendUtility.sendMessage(admin, "Packet send..");
                PacketSendUtility.sendPacket(admin, p);
            });
        } catch (IOException e) {
            PacketSendUtility.sendMessage(admin, "An error has occurred.");
            logger.warn("IO Error.", e);
        }
    }

    private Optional<SM_CUSTOM_PACKET> processLines(List<String> lines) {
        SM_CUSTOM_PACKET[] packet = {null};
        boolean[] init = {false};

        lines.forEach(row -> {
            String[] tokens = row.substring(0, 48).trim().split(" ");
            
            for (int i = 0; i < tokens.length; i++) {
                if (!init[0]) {
                    if (i == 1) {
                        packet[0] = new SM_CUSTOM_PACKET(Integer.decode("0x" + tokens[i] + tokens[i - 1]));
                        init[0] = true;
                    }
                }
                else if (lines.indexOf(row) > 0 || i > 4) {
                    packet[0].addElement(PacketElementType.C, "0x" + tokens[i]);
                }
            }
        });
        
        return Optional.ofNullable(packet[0]);
    }

    @Override
    public void onFail(Player player, String message) {
        sendUsage(player);
    }

    private void sendUsage(Player player) {
        PacketSendUtility.sendMessage(player, "Usage: //raw [name]");
    }
}