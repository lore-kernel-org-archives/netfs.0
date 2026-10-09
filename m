Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AFE4E66A9
	for <netfs@lists.linux.dev>; Fri,  9 Oct 2026 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557421; cv=none; b=D8WWvhXzPiSbcOy4bpKlFPgvlHtJZJ3pFa3tTraU0aQFiln3tV0Zc0eLX3CPKLE5tgmiR8sVFlzjWVJkC3uFdqXy9gBcdGQ4urbdB3PTYj+SHcSvJXP6DyYR/5h6KyklfS1MGEoWbLI054ToHfy8jW5eLj+3jZsNWDGUhP6Yvn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557421; c=relaxed/simple;
	bh=QMBBcDwgjsDjyl3EBe3JFAp/DeQlExENh9tN3Jkup4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:content-type; b=A/Dgtl4CkkS3/D2vZKsMPMwMvn8ZBumKmMLClyxXNheiLl2LJqu0geAe7JARu26Z12HyyB70VRFQAFbw3CRavbWxjnuBipQxsI5HXA+USblNdhyrukM1HS6dxOfwWoXh4FHZLETw1IWPigI4vxzy0jb1dpqoyLt7Qly9ONatozU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YWE3qqfr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWE3qqfr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791557419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=denjLYVgwbF9iEIwmMqmhaeRtlsrnClW1EGbNR+b3NA=;
	b=YWE3qqfrS/6KkORHA+mQpjEN/OVwqpV97pPVHnDYH1cCx/8hDBax+8cpRWG76COnfvgiO+
	biNB4t5quNnLYwaB1nVCENvgBzSmT0SoWtv99r1HZChO2Jm4NaRIIwBRfbZEaeaS4RLSQS
	o0JkWsjDpvMEgiwCI6JEtoYA2iQAf+s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-_Vu1oFGHP0-pzuVCYDAk2w-1; Fri, 9 Oct 2026 14:50:16 +0000
X-MC-Unique: _Vu1oFGHP0-pzuVCYDAk2w-1
X-Mimecast-MFC-AGG-ID: _Vu1oFGHP0-pzuVCYDAk2w_1791557416
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-9179d9cde17so67082686d6.0
        for <netfs@lists.linux.dev>; Fri, 09 Oct 2026 07:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791557416; x=1792162216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=denjLYVgwbF9iEIwmMqmhaeRtlsrnClW1EGbNR+b3NA=;
        b=k+hfdlv8V/IMswXnpKumllmjaXu5YP9mHQW73P+crbne4h0GCWaU8QGBBcgi8eK++2
         B0ybZEiq67hRJUteLuHfZxssKsCICCfO4AN6QRoGDpVulWCweKkfHg/j/67U/U+Zi5dH
         BKAmH79gna7IrjOT3WkK+QDD/L9JSKTq5A4xoGB8WjUsnngWpavCyQb0kvGAD5HeBObI
         ik3KJS+c8dj8TR9WOVqapOyMQisJXQFPvsJvT4y3wKPQxg2bUWKp1kUy9ILMEUbgyJzu
         ExGyC+SQRWR4hh6xdYizDcQjKT71zYp+ENTJGZR6g37NPm6B9a1Uw+m5zGZAZ84SGKGA
         QFPQ==
X-Forwarded-Encrypted: i=1; AKwUvByF8v8eZGJKiGB7EQ23Dm1mksIcsjDJgul94W88zoZdZyNBUkr53N6OcnRlelWRA1fmAIbGNA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJXcC3jqBNOXRB8FlZBB0p5VQ8hEECnSXduBsReH7VqGMEc3Stc
	VQsSxznKic/Ro35xGW0DzmwTD6UScbc/aXbvBu3ZqYoUhJ6Mz/QiPYcdHENbc261PLg6jZuDe43
	N0C7dYlxXl2lTi/6GZOveMfYH8Ytm3kUu5rYcM+KDK3KeXJUjkEOh/W3Z
X-Gm-Gg: AYBFou3oIareIGfxyenCzHoudEFxsoOYKHj3MzGQWUd+duI9TsSpLXS/6raMFGmr7Hq
	f1wvfIcCoMTX7biDSa2HZN3MBcg40mJUBNDSWAN4cpDDtC4CZD4dXwPEADzC3mS2EUBoqTDSXru
	eT7RLJYioKN2Q9QMTeYU3sbqHeRJMpx48NwX7YcZX2dotjhuLzWJvHVKPCVJwchPtrOrswp3Mb2
	W9mhSphp9D6GqPE5IcNJL4Um/gEtLtsjR7UhWqcwD8Vs4SAvk0IWyINhwG5PvJQmnT56nNzxU2/
	8V96CM6d54MX8bFOV67+la9GcU+jsedA6xhg/wWQY2k2xpx60J4Abs5FxtAfjSqHUjgZmQwW1/A
	HAnTFyTSc5o/Z1K7Hcsqx0z/iZLJ8kh+xaLmT7OPb7xeZkM8Ef0xg9zX+CC8Dox6+TviLuWetkX
	ojHYx70HoEgy1NzQ==
X-Received: by 2002:ad4:5def:0:b0:91b:53e5:9263 with SMTP id 6a1803df08f44-91b55531337mr36208416d6.21.1791557415673;
        Fri, 09 Oct 2026 07:50:15 -0700 (PDT)
X-Received: by 2002:ad4:5def:0:b0:91b:53e5:9263 with SMTP id 6a1803df08f44-91b55531337mr36207516d6.21.1791557414875;
        Fri, 09 Oct 2026 07:50:14 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550dfb6csm20185456d6.45.2026.10.09.07.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 07:50:14 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Matthew Wilcox <willy@infradead.org>,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	ceph-devel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [v3] fscache, cachefiles: Fix resize handling
Date: Fri,  9 Oct 2026 14:50:10 +0000
Message-Id: <20261009145010.2380147-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1091807.1791483394@warthog.procyon.org.uk>
References: <1091807.1791483394@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RTGrbzwW0PvRHqgXMcxeZwER-LGW2tqgwuY_dE9mQGo_1791557416
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Hi David,

Reviewed this on your netfs-next-5 tree. The resize helper it changes is not in our testing branch.

For Ceph this is the right split. ceph_fill_file_size() stores the new i_size before __ceph_do_pending_vmtruncate() trims the page cache and the cookie, so the worker can no longer see that the file shrank. i_truncate_shrank records size < isize at the truncate_seq bump. Without that, a truncate that is still above the stale cache size takes the grow path and leaves the backing tail in place.

IMHO the same flag is right for the other filesystems. AFS, 9p, and cifs_resize_file_locked() still have the old size at the call, so shrank is a direct comparison. The grow paths pass false, collapse passes true, and cachefiles shortens only when the caller says the file shrank and the backing file is actually larger.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

