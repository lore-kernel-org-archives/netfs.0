Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E7A421F16
	for <netfs@lists.linux.dev>; Fri,  8 May 2026 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778269413; cv=none; b=DOod9OTc1FSikiYxR3biEN0sHsTFNuAa2PYcWrLP0Z/yAmvWFlAIimNCLH9XK4u3QcT34GeJwmI+LmjWaWV4t8csQcQrZ9oRJQR0CHQiD+hsBad3hWQSvOodlLhFJpeml0J74SzqJJSsmcgOPGpeIQxBwWomQFrNXZwlhKH7wkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778269413; c=relaxed/simple;
	bh=hyX0DHxFq+BD9QNx9LydBkqPo3cWiz/EDdJMU3qIP7o=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=laN6RfqZZ3f0Y2ZA1DXoA5rgcVOgvuukrrdUBCT4NjKvhYC+qEcoKuB7VSvOEtlEF9ogGao+NaA4g7ZjcfKlAuGjhZdSycFeXlZ8agAJp01V3MbT3wCvT9K1ae7MFS24Hij/yiZmEydRGS8EXHk8GtxGRiKzXZE/HkZW/tn60Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=grko74+z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grko74+z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778269411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tl/62/8NKdnfOkRMvqHV6kNqj2NbRFQL6QkZB7a3nog=;
	b=grko74+z+gGbzyLjzvC9Ur4oPzcdDx2kK41TqsHhN4XzpiZya7KWlWwXG5zW2mA4rqh2Bb
	C+Mgl1wl0B/gJraTisExS42xJf+TV9E1l26bR/Ev5O9stJJWXOK6PfycxdkJu0yNL37H8F
	vHib8wbExwxh4TQlD//jJRad7nSuJS8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-OBLFGJWHPyOzNzCAh4i3MQ-1; Fri,
 08 May 2026 15:43:25 -0400
X-MC-Unique: OBLFGJWHPyOzNzCAh4i3MQ-1
X-Mimecast-MFC-AGG-ID: OBLFGJWHPyOzNzCAh4i3MQ_1778269394
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79F0B195608B;
	Fri,  8 May 2026 19:43:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.83])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5A1B19560A2;
	Fri,  8 May 2026 19:43:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260508163759.16231-1-reynard.adrien.08@gmail.com>
References: <20260508163759.16231-1-reynard.adrien.08@gmail.com>
To: Adrien Reynard <reynard.adrien.08@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
    Frederic Weisbecker <frederic@kernel.org>,
    Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
    Joel Fernandes <joelagnelf@nvidia.com>,
    Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
    Uladzislau Rezki <urezki@gmail.com>,
    Steven Rostedt <rostedt@goodmis.org>,
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
    Lai Jiangshan <jiangshanlai@gmail.com>,
    Zqiang <qiang.zhang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
    Shuah Khan <skhan@linuxfoundation.org>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    "Rafael J. Wysocki" <rafael@kernel.org>,
    Danilo Krummrich <dakr@kernel.org>,
    David Howells <dhowells@redhat.com>,
    Paulo Alcantara <pc@manguebit.org>,
    Masami Hiramatsu <mhiramat@kernel.org>,
    rcu@vger.kernel.org (open
 list:READ-COPY UPDATE (RCU)),
    linux-doc@vger.kernel.org (open
 list:DOCUMENTATION),
    linux-kernel@vger.kernel.org (open list),
    driver-core@lists.linux.dev (open list:DRIVER CORE, KOBJECTS, DEBUGFS AND
 SYSFS),
    netfs@lists.linux.dev (open list:FILESYSTEMS [NETFS LIBRARY]),
    linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS [NETFS LIBRARY]),
    linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: Re: [PATCH 2/5] docs: fix repeated word 'that' across documentation
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 08 May 2026 20:43:04 +0100
Message-ID: <298041.1778269384@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 6O3gOaq6tktnUAPxFc0TUQMj-h1ieojAiPD-eitAV_Q_1778269394
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <298040.1778269384.1@warthog.procyon.org.uk>

Adrien Reynard <reynard.adrien.08@gmail.com> wrote:

> -  three states, we know that that CPU has exited any previous RCU

This is arguably correct.  The two 'that' words are functionally different.
If you look at another language, say Hungarian, they are different words
(e.g. 'hogy' vs 'az').

David

