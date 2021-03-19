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
            //Account stuff
            CreateMap<Account, AccountDTO>();
            CreateMap<AccountDTO, Account>();

            CreateMap<AccountWeapon, AccountWeaponDTO>();
            CreateMap<AccountWeaponDTO, AccountWeapon>();
            
            CreateMap<AccountInventory, AccountInventoryDTO>();
            CreateMap<AccountInventoryDTO, AccountInventory>();

            CreateMap<AccountFacility, AccountFacilityDTO>();
            CreateMap<AccountFacilityDTO, AccountFacility>();

            //Weapon data
            CreateMap<Weapon, WeaponDTO>()
                .ForMember(dest => dest.Element,
                           opt => opt.MapFrom(src => src.Element.Element1))
                .ForMember(dest => dest.WeaponSeries,
                           opt => opt.MapFrom(src => src.WeaponSeries.WeaponSeries1))
                .ForMember(dest => dest.WeaponType,
                           opt => opt.MapFrom(src => src.WeaponType.WeaponType1))
                .ForMember(dest => dest.Weapon,
                           opt => opt.MapFrom(src => src.Weapon1));

            CreateMap<Element, ElementDTO>()
                .ForMember(dest => dest.Element,
                           opt => opt.MapFrom(src => src.Element1));

            CreateMap<WeaponType, WeaponTypeDTO>()
                .ForMember(dest => dest.WeaponType,
                           opt => opt.MapFrom(src => src.WeaponType1));

            CreateMap<WeaponSeries, WeaponSeriesDTO>()
                .ForMember(dest => dest.WeaponSeries,
                           opt => opt.MapFrom(src => src.WeaponSeries1));

            //Weapon passives
            CreateMap<Passive, PassiveDTO>()
                .ForMember(dest => dest.Ability,
                           opt => opt.MapFrom(src => src.Ability.Ability1))
                .ForMember(dest => dest.Element,
                           opt => opt.MapFrom(src => src.Element.Element1))
                .ForMember(dest => dest.WeaponType,
                           opt => opt.MapFrom(src => src.WeaponType.WeaponType1));

            //Facility data
            CreateMap<Facility, FacilityDTO>()
                .ForMember(dest => dest.Category,
                           opt => opt.MapFrom(src => src.Category.Category1))
                .ForMember(dest => dest.Facility,
                           opt => opt.MapFrom(src => src.Facility1));
            CreateMap<FacilityDTO, Facility>();

            //Material data
            CreateMap<Material, MaterialDTO>()
                .ForMember(dest => dest.Category,
                           opt => opt.MapFrom(src => src.Category.Category1))
                .ForMember(dest => dest.Material,
                           opt => opt.MapFrom(src => src.Material1));
            CreateMap<MaterialDTO, Material>();

        }
    }
}
