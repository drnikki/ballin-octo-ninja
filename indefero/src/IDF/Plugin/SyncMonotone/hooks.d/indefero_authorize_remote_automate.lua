-- ***** BEGIN LICENSE BLOCK *****
-- This file is part of InDefero, an open source project management application.
-- Copyright (C) 2008-2011 Céondo Ltd and contributors.
-- Copyright (C) 2010 Thomas Keller <me@thomaskeller.biz>
--                    Richard Levitte <richard@levitte.org>
--
-- InDefero is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 2 of the License, or
-- (at your option) any later version.
--
-- InDefero is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
--
-- ***** END LICENSE BLOCK *****

--
-- This script reads key identities from a file "remote-automate-permissions"
-- in the configuration directory and permits those authenticating with one
-- of those keys to perform dangerous (read/write) remote automate operations.
-- The format of the file is very simple, one key identity on every line.
-- Lines starting with # are ignore, as well as empty lines.
--
-- It's possible to configure this script to allow the performance of some
-- remote automate commands anonymously, through the variable
-- ARA_safe_commands, which has to be a table of commands as strings.
-- One example configuration, taken from the setup at code.monotone.ca, could
-- be this:
--
-- ARA_safe_commands = {
--    "get_corresponding_path", "get_content_changed", "tags", "branches",
--    "common_ancestors", "packet_for_fdelta", "packet_for_fdata",
--    "packets_for_certs", "packet_for_rdata", "get_manifest_of",
--    "get_revision", "select", "graph", "children", "parents", "roots",
--    "leaves", "ancestry_difference", "toposort", "erase_ancestors",
--    "descendents", "ancestors", "heads", "get_file_of", "get_file",
--    "interface_version", "get_attributes", "content_diff",
--    "file_merge", "show_conflicts", "certs", "keys", "get_extended_manifest_of"
-- }
--
do
   local _safe_commands = {}
   if ARA_safe_commands then
      _safe_commands = ARA_safe_commands
   end

   local _save_get_remote_automate_permitted = get_remote_automate_permitted
   function get_remote_automate_permitted(key_identity, command, options)
      local permfile =
	 io.open(get_confdir() .. "/remote-automate-permissions", "r")
      if (permfile == nil) then
        return false
      end

      -- See if the incoming key matches any of the key identities or
      -- patterns found in the permissions file.
      local matches = false
      local line = permfile:read()
      while (not matches and line ~= nil) do
        if not globish_match("#*", line) then
          local _, _, ln = string.find(line, "%s*([^%s]*)%s*")
          if ln == "*" then matches = true end
          if ln == key_identity.id then matches = true end
          if globish_match(ln, key_identity.name) then matches = true end
          line = permfile:read()
	    end
      end
      io.close(permfile)
      if matches then return true end

      -- No matching key found, let's see if the command matches one the
      -- admin allowed to be performed anonymously
      for _,v in ipairs(_safe_commands) do
        if (v == command[1]) then
          return true
        end
      end

      -- No matches found anywhere, then don't permit this operation
      return false
   end
end
