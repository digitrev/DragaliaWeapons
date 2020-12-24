using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Models.DTO
{
    public class AccountDTO
    {
        public int AccountId { get; set; }
        public string AccountName { get; set; }
        public string AccountEmail { get; set; }

        public static AccountDTO ToDTO(Account account) => new AccountDTO
        {
            AccountId = account.AccountId,
            AccountName = account.AccountName,
            AccountEmail = account.AccountEmail
        };

    }
}
