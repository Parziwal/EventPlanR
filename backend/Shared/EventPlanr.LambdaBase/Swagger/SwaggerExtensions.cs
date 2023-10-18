﻿using EventPlanr.Domain.Constants;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;

namespace EventPlanr.LambdaBase.Swagger;

public static class SwaggerExtensions
{
    public static IServiceCollection AddSwagger(this IServiceCollection services)
    {
        services.AddEndpointsApiExplorer();
        services.AddSwaggerGen(builder =>
        {
            builder.SupportNonNullableReferenceTypes();
            builder.SchemaFilter<RequiredNotNullableSchemaFilter>();
        });

        return services;
    }

    public static IApplicationBuilder UseSwagger(this IApplicationBuilder app)
    {
        var basePath = Environment.GetEnvironmentVariable("BASE_PATH");

        app.UseSwagger(c =>
        {
            c.RouteTemplate = $"/{basePath}/swagger/{{documentname}}/swagger.json";
        });

        if (EnvironmentTypes.IsDevelopment())
        {
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint($"/{basePath}/swagger/v1/swagger.json", "v1");
                c.RoutePrefix = $"{basePath}/swagger";
            });
        }

        return app;
    }
}
