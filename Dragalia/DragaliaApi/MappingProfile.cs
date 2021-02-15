using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DragaliaApi.Models.DTO;
using DragaliaApi.Models;

namespace DragaliaApi
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Account, AccountDTO>();
            CreateMap<AccountDTO, Account>();
            CreateMap<Weapon, WeaponDTO>()
                .ForMember(
                    dest => dest.Element,
                    opt => opt.MapFrom(src => src.Element.Element1))
                .ForMember(
                    dest => dest.WeaponSeries,
                    opt => opt.MapFrom(src => src.WeaponSeries.WeaponSeries1))
                .ForMember(
                    dest => dest.WeaponType,
                    opt => opt.MapFrom(src => src.WeaponType.WeaponType1))
                .ForMember(
                    dest => dest.Weapon,
                    opt => opt.MapFrom(src => src.Weapon1));
            CreateMap<AccountWeapon, AccountWeaponDTO>();
            CreateMap<AccountWeaponDTO, AccountWeapon>();
        }
    }
}
