using AutoMapper;
using AutoMapper.Internal;
using EventPlanr.Application.Exceptions.Common;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Pagination;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace EventPlanr.Application.Extensions;

public static class QueryableExtensions
{
    public static IQueryable<TSource> Where<TSource>(
        this IQueryable<TSource> source,
        bool condition,
        Expression<Func<TSource, bool>> conditionTruePredicate,
        Expression<Func<TSource, bool>>? conditionFalsePredicate = null)
    {
        if (condition)
        {
            return source.Where(conditionTruePredicate);
        }
        else if (conditionFalsePredicate != null)
        {
            return source.Where(conditionFalsePredicate);
        }
        else
        {
            return source;
        }
    }

    public static async Task<TSource> SingleEntityAsync<TSource>(
        this IQueryable<TSource> source,
        Expression<Func<TSource, bool>> predicate)
    {
        return await source.SingleOrDefaultAsync(predicate)
            ?? throw new EntityNotFoundException(typeof(TSource).Name);
    }

    public static IQueryable<TSource> OrderBy<TSource, TDto>(
        this IQueryable<TSource> source,
        PageWithOrderDto page,
        IConfigurationProvider mappings,
        Expression<Func<TSource, object?>> defaultOrder,
        OrderDirection defaultOrderDirection = OrderDirection.Ascending)
    {
        var orderExpression = GetOrderKeySelector<TSource, TDto>(page, mappings) ?? defaultOrder;
        var orderDirection = page.OrderDirection ?? defaultOrderDirection;
        return orderDirection == OrderDirection.Ascending 
            ? source.OrderBy(orderExpression) : source.OrderByDescending(orderExpression);
    }

    public static async Task<PaginatedListDto<TSource>> ToPaginatedListAsync<TSource>(
        this IQueryable<TSource> source,
        PageDto page)
    {
        var count = await source.CountAsync();
        var items = await source
            .Skip((page.PageNumber - 1) * page.PageSize)
            .Take(page.PageSize)
            .ToListAsync();

        return new PaginatedListDto<TSource>(items, count, page.PageNumber, page.PageSize);
    }

    private static Expression<Func<TSource, object?>>? GetOrderKeySelector<TSource, TDto>(
        PageWithOrderDto page,
        IConfigurationProvider mappings)
    {
        var propertyMap = mappings.Internal().FindTypeMapFor<TSource, TDto>()
            ?.PropertyMaps
            ?.FirstOrDefault(m => m.CustomMapExpression != null && m.DestinationName == page.OrderBy);

        if (page.OrderBy != null && propertyMap != null)
        {
            var parameter = Expression.Parameter(typeof(TSource));
            var property = Expression.Property(parameter, propertyMap.SourceMember.Name);
            var propAsObject = Expression.Convert(property, typeof(object));

            if (propAsObject != null)
            {
                return Expression.Lambda<Func<TSource, object?>>(propAsObject, parameter);
            }
        }

        return null;
    }
}
