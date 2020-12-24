using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Models.DTO
{
    public class AccountWeaponDTO
    {
        public int AccountId { get; set; }
        public int WeaponId { get; set; }
        public int Copies { get; set; }
        public int CopiesWanted { get; set; }
        public int WeaponLevel { get; set; }
        public int WeaponLevelWanted { get; set; }
        public int Unbind { get; set; }
        public int UnbindWanted { get; set; }
        public int Refine { get; set; }
        public int RefineWanted { get; set; }
        public bool Slot { get; set; }
        public bool SlotWanted { get; set; }
        public bool Bonus { get; set; }
        public bool BonusWanted { get; set; }
        public virtual WeaponDTO Weapon { get; set; }

        public static AccountWeaponDTO ToDTO(AccountWeapon accountWeapon) => new AccountWeaponDTO
        {
            AccountId = accountWeapon.AccountId,
            WeaponId = accountWeapon.WeaponId,
            Copies = accountWeapon.Copies,
            CopiesWanted = accountWeapon.CopiesWanted,
            WeaponLevel = accountWeapon.WeaponLevel,
            WeaponLevelWanted = accountWeapon.WeaponLevelWanted,
            Unbind = accountWeapon.Unbind,
            UnbindWanted = accountWeapon.UnbindWanted,
            Refine = accountWeapon.Refine,
            RefineWanted = accountWeapon.RefineWanted,
            Slot = accountWeapon.Slot,
            SlotWanted = accountWeapon.Slot,
            Bonus = accountWeapon.Bonus,
            BonusWanted = accountWeapon.BonusWanted,
            Weapon = accountWeapon.Weapon == null ? null : WeaponDTO.ToDTO(accountWeapon.Weapon)
        };
    }
}
