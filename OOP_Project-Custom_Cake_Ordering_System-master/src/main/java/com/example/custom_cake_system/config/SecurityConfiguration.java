package com.example.custom_cake_system.config;
import jakarta.servlet.DispatcherType;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
/*
Without @Configuration beans will not be created, and dependency injection will not happen reliably
With @Configuration, Spring will:
    1) scan the project
    2) find the class and mark it as a configuration source
    3) sees @Bean, executes it once and stores the result in container
    4) when used elsewhere, Spring will return the same instance, automatically managing dependencies
*/
@EnableWebSecurity
/*
tells the program to turn on Spring Security for web apps, enables things like security filters and
authentication handling
additionally without it, Spring Security will apply the default authentication/authorization rules
us defining it essentially tells Spring Security to use OUR security rules
 */
public class SecurityConfiguration  {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{

        http
                .csrf(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests(auth -> auth
                        .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.INCLUDE).permitAll()
                        .requestMatchers("/").permitAll()
                        .requestMatchers("/css/**", "/js/**", "/images/**").permitAll()
                        .requestMatchers("/error").permitAll()
                        .requestMatchers("/user/signup","/user/perform_signup","/user/perform_signup/**").permitAll()
                        .requestMatchers("/user/login", "/user/perform_login","/user/perform_login/**").permitAll()
                        .requestMatchers("/admin/**").hasRole("1")
                        .anyRequest().authenticated()
                )
                .formLogin(form -> form
                        .loginPage("/user/login")
                        .loginProcessingUrl("/perform_login")
                        .defaultSuccessUrl("/home", true)
                        .failureUrl("/user/login?error=true")
                        .permitAll()
                )

                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/user/login?logout=true")
                );
        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return NoOpPasswordEncoder.getInstance(); // allows plain text passwords
    }
}
