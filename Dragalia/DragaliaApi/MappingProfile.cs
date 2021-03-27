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

            CreateMap<AccountAdventurer, AccountAdventurerDTO>();
            CreateMap<AccountAdventurerDTO, AccountAdventurer>();

            CreateMap<AccountDragon, AccountDragonDTO>();
            CreateMap<AccountDragonDTO, AccountDragon>();

            CreateMap<AccountFacility, AccountFacilityDTO>();
            CreateMap<AccountFacilityDTO, AccountFacility>();

            CreateMap<AccountInventory, AccountInventoryDTO>();
            CreateMap<AccountInventoryDTO, AccountInventory>();

            CreateMap<AccountPassive, AccountPassiveDTO>();
            CreateMap<AccountPassiveDTO, AccountPassive>();

            CreateMap<AccountWeapon, AccountWeaponDTO>();
            CreateMap<AccountWeaponDTO, AccountWeapon>();

            CreateMap<AccountWyrmprint, AccountWyrmprintDTO>();
            CreateMap<AccountWyrmprintDTO, AccountWyrmprint>();

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
                           opt => opt.MapFrom(src => src.Ability.GenericName))
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

            //Adventurers
            CreateMap<Adventurer, AdventurerDTO>()
                .ForMember(dest => dest.Adventurer,
                           opt => opt.MapFrom(src => src.Adventurer1))
                .ForMember(dest => dest.Element,
                           opt => opt.MapFrom(src => src.Element.Element1))
                .ForMember(dest => dest.WeaponType,
                           opt => opt.MapFrom(src => src.WeaponType.WeaponType1));
            CreateMap<AdventurerDTO, Adventurer>();

            //Dragon
            CreateMap<Dragon, DragonDTO>()
                .ForMember(dest => dest.Dragon,
                           opt => opt.MapFrom(src => src.Dragon1))
                .ForMember(dest => dest.Element,
                           opt => opt.MapFrom(src => src.Element.Element1));
            CreateMap<DragonDTO, Dragon>();

            //Wyrmprints
            CreateMap<Wyrmprint, WyrmprintDTO>()
                .ForMember(dest => dest.Wyrmprint,
                           opt => opt.MapFrom(src => src.Wyrmprint1))
                .ForMember(dest => dest.Affinity,
                           opt => opt.MapFrom(src => src.Affinity.Affinity1))
                .ForMember(dest => dest.Abilities,
                           opt => opt.MapFrom(
                               src => src.WyrmprintAbilities
                                .Where(wa => wa.AbilityLevel == 3)
                                .Select(wa => wa.Ability.GenericName)
                                .ToList()));
            CreateMap<WyrmprintDTO, WyrmprintDTO>();

            //Quests
            CreateMap<Quest, QuestDTO>()
                .ForMember(dest => dest.Quest,
                           opt => opt.MapFrom(src => src.Quest1));
            CreateMap<QuestDTO, Quest>();

            //material quests
            CreateMap<MaterialQuest, MaterialQuestDTO>();
            CreateMap<MaterialQuestDTO, MaterialQuest>();
        }
    }
}
