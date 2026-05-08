Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1883337B81
	for <netfs@lists.linux.dev>; Fri,  8 May 2026 17:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778260535; cv=none; b=QqePX2IgIRtgnDf0rbaxJH8rUV2hKzfDShTZTI4yAkVEn4mIIRblC56146xU3/krf8iJ8wsYr72IthGTsV+SLn3Y/RfFebefaVC+jWlJ8QXTUZ1wu0CJ+iw5Ms2zQGHTxp5y3cwe4x1+4YI2xyog2Pnmx4xI1J2JQtHIWcdeJY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778260535; c=relaxed/simple;
	bh=B5LPyOWApy59FvhRnEByqk4wlO4qBooEaHT8YJ0k2J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BmKk5aoaEesdiQh3fqW6jkSKZs5evYaNtlfOv9WlcGsswEHGIp6pAURYsYxwZquL/AQs6kJOkdW05AFaWk4u6ebM5Rut9BhCVzU4gvA2raBYy/T5B4xPFYfBWW9Espqj2CQJAvRaRW7SJDkPcCu+qq8mGkZ7OYG9r7zpkY7Pzjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hP4mIdgX; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hP4mIdgX"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7df05fc49e5so2240594a34.3
        for <netfs@lists.linux.dev>; Fri, 08 May 2026 10:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778260531; x=1778865331; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rUvovzVI0WfmpARa7cBsFpdtftv1IZUf0H6p/9La+aQ=;
        b=hP4mIdgXxrVtR119Vvq+ny2wuBXEVyedFIzb51mtKGwMpZ1xiY4fS9i60nlBBWCcGR
         b9eRMn5ycvw96PjGQD4xEKh2AATnbPfIm80JZ2qzBMk4ytu6EZ0WNQLjQA6O5heJ32Sc
         3CHaWFpAc2gmKLQJYDNGmGiethu+kA4bu4OkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778260531; x=1778865331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rUvovzVI0WfmpARa7cBsFpdtftv1IZUf0H6p/9La+aQ=;
        b=DMs+l5xdGsgZ4B29mLdkOoSHN24RiJeN4kGuYfOkvmaNnTexF/1/BnUZcTxTmifWxh
         QCxMzLGZqB05KtbOurrnOjioK2v32O1KfktRQC+NIXVF6h8dacdU5afzX6HSOMximN7G
         j8Ar3EJzM2NkIDQus8JfNIiacNbnxU/GLuhualq/646aSfsXCqsEnOexF3QT4kdcw01t
         FYKRUTHYL9/Y5tlJ+lukmG53NOKKcnoImCvZYZamZSbj/zQxKt7otvPWVaJdty7tu+96
         SstYYtn08Dn6p61YSM2EQv1CMxYLFatdnCxUWXH0tS2oTZveIArnKDfKUR+nAogv24gY
         TXCw==
X-Forwarded-Encrypted: i=1; AFNElJ+NjXbQm589HHOHckZsgTCOAZmoKFRm9Qt+rgSI33R54iLULS3NGZ99TjSO/RjSvyPap+KiOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOavy7tnTNzuYgyGhEgHfKxHiNn69+GRl4iOdze+1qJRNh5KLA
	v3K5Jo3G3u1e5r/G02uOKUSeNfsPdzWYh4HiP9JIGfTF0bZRrVWtHyCEnePN363GlF0=
X-Gm-Gg: AeBDiesbGVZ/+Esi/SmOeLaO8pg3hYTnNSOlmxNMuit+DSBzGO4Kq8U9P2DGwICJpFe
	6T5Exvmuw+aa0kdc82U33A+GhoRqCdPx36d/ke7aGyxb1IPzg8cA7g54+QYnOtGstxPKDM81Wj2
	DnrXN/EEQjv4F3AixvMTIU3vPpbr/lG9jCRBVz0NZulsNgziN7hGJ0I5kkbPoBugSmKE5dq9Tjm
	WMPOskeAiPafzjq153B6sh8ZFEi9fRgr/RXGVhMdZI1oeW1jNywCxHUPHTfjM5szyJ629cmK+8G
	EIdEYpF+RqQ8CZrPZHsfNKDH9RX6EHopGAEEBk+BJFOEI3O6rmdHNUjFqhsg3tFKdVgRRnNUKqA
	QjiZpvpIoQGZ5/OBJUSqqZ5ZeUhP4EYm9253lL7EdhdjFOZYZqjHayesOt+8HoG/TcBx3a1wbBS
	d/cDqU1A4WKCcghgAD2N2fYfwXeg9iLR0=
X-Received: by 2002:a05:6830:8089:b0:7e3:7dcf:9d3f with SMTP id 46e09a7af769-7e37dcf9f5dmr17419a34.16.1778260531374;
        Fri, 08 May 2026 10:15:31 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d50611sm1482059a34.16.2026.05.08.10.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 10:15:30 -0700 (PDT)
Message-ID: <1501caea-8cff-4968-aca6-e8d4b20e0e80@linuxfoundation.org>
Date: Fri, 8 May 2026 11:15:28 -0600
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] docs: fix repeated word 'that' across documentation
To: Adrien Reynard <reynard.adrien.08@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 "open list:READ-COPY UPDATE (RCU)" <rcu@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS"
 <driver-core@lists.linux.dev>,
 "open list:FILESYSTEMS [NETFS LIBRARY]" <netfs@lists.linux.dev>,
 "open list:FILESYSTEMS [NETFS LIBRARY]" <linux-fsdevel@vger.kernel.org>,
 "open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260508163759.16231-1-reynard.adrien.08@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260508163759.16231-1-reynard.adrien.08@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/26 10:37, Adrien Reynard wrote:

Missing commit log in all your patches - I don't patch 1/5 in
my Inbox.

> Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
> ---
>   Documentation/RCU/rcu.rst                          | 2 +-
>   Documentation/driver-api/driver-model/overview.rst | 2 +-
>   Documentation/filesystems/netfs_library.rst        | 2 +-
>   Documentation/trace/histogram-design.rst           | 2 +-
>   Documentation/trace/histogram.rst                  | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
> index bf6617b330a7..320ad3292b75 100644
> --- a/Documentation/RCU/rcu.rst
> +++ b/Documentation/RCU/rcu.rst
> @@ -32,7 +32,7 @@ Frequently Asked Questions
>     Just as with spinlocks, RCU readers are not permitted to
>     block, switch to user-mode execution, or enter the idle loop.
>     Therefore, as soon as a CPU is seen passing through any of these
> -  three states, we know that that CPU has exited any previous RCU
> +  three states, we know that CPU has exited any previous RCU

The original intent might have been to say, "that cpu", so adding
the missing comma after the first "that" or change "that" to "the"
would make sense.


>     read-side critical sections.  So, if we remove an item from a
>     linked list, and then wait until all CPUs have switched context,
>     executed in user mode, or executed in the idle loop, we can
> diff --git a/Documentation/driver-api/driver-model/overview.rst b/Documentation/driver-api/driver-model/overview.rst
> index b3f447bf9f07..c1966d506d55 100644
> --- a/Documentation/driver-api/driver-model/overview.rst
> +++ b/Documentation/driver-api/driver-model/overview.rst
> @@ -55,7 +55,7 @@ struct pci_dev now looks like this::
>   Note first that the struct device dev within the struct pci_dev is
>   statically allocated. This means only one allocation on device discovery.
>   
> -Note also that that struct device dev is not necessarily defined at the
> +Note also that struct device dev is not necessarily defined at the

Sam comment here, replace "that" with "the" or add missing comma

>   front of the pci_dev structure.  This is to make people think about what
>   they're doing when switching between the bus driver and the global driver,
>   and to discourage meaningless and incorrect casts between the two.
> diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
> index ddd799df6ce3..4033de4535ac 100644
> --- a/Documentation/filesystems/netfs_library.rst
> +++ b/Documentation/filesystems/netfs_library.rst
> @@ -626,7 +626,7 @@ A number of members are available for access/use by the filesystem:
>   
>      These are set by the filesystem or the cache in ->prepare_read() or
>      ->prepare_write() for each subrequest to indicate the maximum number of
> -   bytes and, optionally, the maximum number of segments (if not 0) that that
> +   bytes and, optionally, the maximum number of segments (if not 0) that

Same here.

>      subrequest can support.
>   
>    * ``submit_extendable_to``
> diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
> index e92f56ebd0b5..949bbfdb0f16 100644
> --- a/Documentation/trace/histogram-design.rst
> +++ b/Documentation/trace/histogram-design.rst
> @@ -738,7 +738,7 @@ creates its own variable, wakeup_lat, but nothing yet uses it::
>   
>   Looking at the sched_waking 'hist_debug' output, in addition to the
>   normal key and value hist_fields, in the val fields section we see a
> -field with the HIST_FIELD_FL_VAR flag, which indicates that that field
> +field with the HIST_FIELD_FL_VAR flag, which indicates that field

Same here


>   represents a variable.  Note that in addition to the variable name,
>   contained in the var.name field, it includes the var.idx, which is the
>   index into the tracing_map_elt.vars[] array of the actual variable
> diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
> index 340bcb5099e7..5b303fabdf32 100644
> --- a/Documentation/trace/histogram.rst
> +++ b/Documentation/trace/histogram.rst
> @@ -1700,7 +1700,7 @@ to that rule is that any variable used in an expression is essentially
>   'read-once' - once it's used by an expression in a subsequent event,
>   it's reset to its 'unset' state, which means it can't be used again
>   unless it's set again.  This ensures not only that an event doesn't
> -use an uninitialized variable in a calculation, but that that variable
> +use an uninitialized variable in a calculation, but that variable

Same here

>   is used only once and not for any unrelated subsequent match.
>   
>   The basic syntax for saving a variable is to simply prefix a unique

thanks,
-- Shuah

